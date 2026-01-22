import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:epub_parser/epub_parser.dart';
import 'package:flutter_template/dependency/local_api/repository/book/book_repository.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/local_api/repository/chapter/entities/chapter_contents_entity.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:html/dom.dart' as html_dom;
import 'package:html/parser.dart' as html_parser;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ImportBookDto {
  final String title;
  final String author;
  final String thumb;
  final List<ImportChapterDto> chapters;

  ImportBookDto({
    required this.title,
    this.author = 'Sưu tầm',
    required this.chapters,
    required this.thumb,
  });
}

class ImportChapterDto {
  final String title;
  final String content;

  ImportChapterDto({required this.title, required this.content});
}

class ImportStoryService {
  final BookRepository _bookRepository;
  final Uuid _uuid = const Uuid();

  ImportStoryService(this._bookRepository);

  Future<String?> importFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) throw Exception('File không tồn tại');

      ImportBookDto? data;
      final extension = p.extension(filePath).toLowerCase();

      // 1. Phân loại và Parse
      if (extension == '.epub') {
        data = await _parseEpub(file);
      } else if (extension == '.txt') {
        data = await _parseTxt(file);
      } else {
        throw Exception('Định dạng không hỗ trợ: $extension');
      }

      if (data == null || data.chapters.isEmpty) {
        throw Exception('File rỗng hoặc không đọc được nội dung');
      }
      logger.i(
        'Import thành công: ${data.title} với ${data.chapters.length} chương',
      );
      // 2. Map sang Entity & Lưu DB
      final bookId = await _saveToDatabase(data);
      return bookId;
    } catch (e) {
      logger.e('Lỗi khi import file: $e');
      rethrow;
    }
  }

  Future<String> _saveToDatabase(ImportBookDto data) async {
    final bookId = _uuid.v4();
    final now = DateTime.now().toIso8601String();

    final storyModel = StoryModel(
      id: bookId,
      name: data.title,
      author: data.author,
      thumb: data.thumb,
    );

    // 1. Tạo BookEntity
    final bookEntity = BookEntity(
      id: bookId,
      storyData: jsonEncode(storyModel.toJson()),
      listChapters: data.chapters
          .mapIndexed(
            (index, c) => ListChapterRes(
              id: _uuid.v4(),
              name: c.title,
            ),
          )
          .toList(),
      timeStamp: now,
      lastReadTime: now,
      isFavorite: true,
      isLocal: true,
    );

    // 2. Gọi Repository để lưu (Transaction nằm trong hàm này)
    await _bookRepository.saveImportedBook(
      book: bookEntity,
      chapterContents: data.chapters.map(
        (e) {
          return ChapterContentsEntity(
            id: _uuid.v4(),
            chapterId: '', // chapterId sẽ được liên kết trong Repository
            content: e.content,
          );
        },
      ).toList(), // Truyền nội dung text riêng
    );

    return bookId;
  }

  Future<ImportBookDto?> _parseEpub(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final epubBook = await EpubReader.readBook(bytes);

      final title = epubBook.Title ?? p.basenameWithoutExtension(file.path);
      final author = epubBook.Author ?? 'Sưu tầm';

      final List<ImportChapterDto> chapters = [];

      void extractChapters(List<EpubChapter> epubChapters) {
        for (final epubChapter in epubChapters) {
          final htmlContent = epubChapter.HtmlContent ?? '';
          final cleanContent = _cleanHtml(htmlContent);

          if (cleanContent.trim().isNotEmpty) {
            chapters.add(
              ImportChapterDto(
                title: epubChapter.Title ?? 'Chương ${chapters.length + 1}',
                content: cleanContent,
              ),
            );
          }
          if (epubChapter.SubChapters != null) {
            extractChapters(epubChapter.SubChapters!);
          }
        }
      }

      extractChapters(epubBook.Chapters ?? []);

      final thumb = await _saveCoverImageLocal(
        epubBook.CoverImage,
        _uuid.v4(),
      );
      return ImportBookDto(
        title: title,
        author: author,
        chapters: chapters,
        thumb: thumb ?? '',
      );
    } catch (e) {
      logger.e('Lỗi khi parse file epub: $e');
      return null;
    }
  }

  String _cleanHtml(String htmlString) {
    if (htmlString.isEmpty) return '';
    final document = html_parser.parse(htmlString);

    // Xử lý xuống dòng trước khi lấy text
    document
        .querySelectorAll('br')
        .forEach((e) => e.replaceWith(html_dom.Text('\n')));
    document
        .querySelectorAll('p')
        .forEach((e) => e.replaceWith(html_dom.Text('${e.text}\n')));

    final rawText = document.body?.text ?? '';

    final lines = rawText.split('\n');
    final buffer = StringBuffer();

    for (final line in lines) {
      final cleanLine = line.trim();
      if (cleanLine.isNotEmpty) {
        buffer.write('<p>$cleanLine</p>');
      }
    }

    return buffer.toString();
  }

  Future<ImportBookDto?> _parseTxt(File file) async {
    try {
      final title = p.basenameWithoutExtension(file.path);
      final List<String> lines = await file.readAsLines();

      final List<ImportChapterDto> chapters = [];
      final StringBuffer currentContent = StringBuffer();
      String currentChapterTitle = 'Mở đầu';

      final RegExp chapterRegex =
          RegExp(r'^\s*(Chương|Chapter|Hồi|Quyển)\s+\d+', caseSensitive: false);

      for (var line in lines) {
        line = line.trim();
        if (line.isEmpty) continue;

        if (chapterRegex.hasMatch(line)) {
          if (currentContent.isNotEmpty) {
            chapters.add(
              ImportChapterDto(
                title: currentChapterTitle,
                content: currentContent.toString(),
              ),
            ); // Content đã đầy thẻ <p>
          }

          currentChapterTitle = line;
          currentContent.clear();
        } else {
          currentContent.write('<p>$line</p>');
        }
      }

      if (currentContent.isNotEmpty) {
        chapters.add(
          ImportChapterDto(
            title: currentChapterTitle,
            content: currentContent.toString(),
          ),
        );
      }

      // Fallback
      if (chapters.isEmpty && lines.isNotEmpty) {
        // Gom toàn bộ dòng lại thành các thẻ p
        final fullContent = lines
            .where((l) => l.trim().isNotEmpty)
            .map((l) => '<p>${l.trim()}</p>')
            .join('');

        chapters.add(ImportChapterDto(title: 'Toàn văn', content: fullContent));
      }

      return ImportBookDto(
        title: title,
        author: '',
        chapters: chapters,
        thumb: '',
      );
    } catch (e) {
      logger.e('Lỗi khi parse file txt: $e');
      return null;
    }
  }

  Future<String?> _saveCoverImageLocal(
    Uint8List? imageBytes,
    String bookId,
  ) async {
    if (imageBytes == null || imageBytes.isEmpty) return null;

    try {
      final directory = await getApplicationDocumentsDirectory();

      final coverDir = Directory(p.join(directory.path, 'covers'));
      if (!await coverDir.exists()) {
        await coverDir.create(recursive: true);
      }
      final filePath = p.join(coverDir.path, '$bookId.jpg');
      final file = File(filePath);

      await file.writeAsBytes(imageBytes);

      return filePath;
    } catch (e) {
      return null;
    }
  }
}
