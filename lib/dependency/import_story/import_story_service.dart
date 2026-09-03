import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:epub_parser/epub_parser.dart';
import 'package:html/dom.dart' as html_dom;
import 'package:html/parser.dart' as html_parser;
import 'package:html_unescape/html_unescape.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/book_repository.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/list_chapter_entity.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/enum/story_type.dart';
import 'package:truyen_cv/dependency/local_api/repository/chapter/entities/chapter_contents_entity.dart';
import 'package:truyen_cv/features/story/detail/entities/story_detail_entity.dart';
import 'package:truyen_cv/shared/utilities/logger.dart';
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

typedef ImportProgressCallback = void Function(int imported, int total);

class ImportStoryService {
  final BookRepository _bookRepository;
  final Uuid _uuid = const Uuid();
  static const int _txtBatchSize = 150;
  static const int _epubBatchSize = 100;
  static const int _txtYieldEveryLines = 1000;
  static const int _epubYieldEveryChapters = 50;
  static const HtmlEscape _htmlEscape = HtmlEscape();
  static final HtmlUnescape _htmlUnescape = HtmlUnescape();

  ImportStoryService(this._bookRepository);

  Future<String?> importFile(
    String filePath, {
    ImportProgressCallback? onProgress,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) throw Exception('File không tồn tại');

      final extension = p.extension(filePath).toLowerCase();

      if (extension == '.epub') {
        final data = await _parseEpub(file);
        if (data == null || data.chapters.isEmpty) {
          throw Exception('File rỗng hoặc không đọc được nội dung');
        }
        final bookId = await _saveParsedBookByBatch(
          data,
          batchSize: _epubBatchSize,
          onProgress: onProgress,
        );
        logger.i(
          'Import thành công: ${data.title} với ${data.chapters.length} chương',
        );
        return bookId;
      }

      if (extension == '.txt') {
        final bookId = await _importTxtFile(file, onProgress: onProgress);
        logger.i(
          'Import TXT thành công: ${p.basenameWithoutExtension(file.path)}',
        );
        return bookId;
      }

      throw Exception('Định dạng không hỗ trợ: $extension');
    } catch (e) {
      logger.e('Lỗi khi import file: $e');
      rethrow;
    }
  }

  Future<String> _saveParsedBookByBatch(
    ImportBookDto data, {
    required int batchSize,
    ImportProgressCallback? onProgress,
  }) async {
    final bookId = _uuid.v4();
    final bookEntity = _createBookEntity(
      bookId: bookId,
      title: data.title,
      author: data.author,
      thumb: data.thumb,
      totalChapter: data.chapters.length,
    );

    await _bookRepository.createImportedBook(bookEntity);

    var imported = 0;
    for (var i = 0; i < data.chapters.length; i += batchSize) {
      final end = (i + batchSize < data.chapters.length)
          ? i + batchSize
          : data.chapters.length;
      final slice = data.chapters.sublist(i, end);
      await _appendChapterBatch(
        bookId: bookId,
        chapters: slice,
        startOrderIndex: imported,
      );
      imported += slice.length;
      onProgress?.call(imported, data.chapters.length);
      await Future<void>.delayed(Duration.zero);
    }

    await _bookRepository.updateImportedBookTotalChapter(
      bookId: bookId,
      totalChapter: imported,
    );

    return bookId;
  }

  BookEntity _createBookEntity({
    required String bookId,
    required String title,
    required String author,
    required String thumb,
    required int totalChapter,
  }) {
    final now = DateTime.now().toIso8601String();
    final storyModel = StoryDetailEntity(
      id: bookId,
      name: title,
      author: author,
      thumb: thumb,
      desc: '',
      listChapter: const [],
      totalChapter: totalChapter.toString(),
      type: StoryType.novel,
    );

    return BookEntity(
      id: bookId,
      storyData: storyModel,
      listChapters: const [],
      timeStamp: now,
      lastReadTime: now,
      isFavorite: true,
      isLocal: true,
    );
  }

  Future<void> _appendChapterBatch({
    required String bookId,
    required List<ImportChapterDto> chapters,
    required int startOrderIndex,
  }) async {
    final chapterEntities = chapters
        .map(
          (chapter) => ListChapterEntity(
            id: _uuid.v4(),
            name: chapter.title,
          ),
        )
        .toList();
    final contents = chapters
        .map(
          (chapter) => ChapterContentsEntity(
            id: _uuid.v4(),
            chapterId: '',
            content: chapter.content,
          ),
        )
        .toList();

    await _bookRepository.appendImportedChapters(
      bookId: bookId,
      chapters: chapterEntities,
      chapterContents: contents,
      startOrderIndex: startOrderIndex,
    );
  }

  Future<String> _importTxtFile(
    File file, {
    ImportProgressCallback? onProgress,
  }) async {
    final bookId = _uuid.v4();
    final title = p.basenameWithoutExtension(file.path);
    final bookEntity = _createBookEntity(
      bookId: bookId,
      title: title,
      author: 'Sưu tầm',
      thumb: '',
      totalChapter: 0,
    );

    final chapterRegex = RegExp(
      r'^\s*(Chương|Chapter|Hồi|Quyển)\s+([0-9]+|[IVXLCDM]+)\b.*',
      caseSensitive: false,
    );

    final batch = <ImportChapterDto>[];
    var imported = 0;
    var hasAnyContent = false;
    var hasChapterMarker = false;
    var currentChapterTitle = 'Mở đầu';
    var currentContent = StringBuffer();

    Future<void> flushBatch() async {
      if (batch.isEmpty) return;
      await _appendChapterBatch(
        bookId: bookId,
        chapters: batch,
        startOrderIndex: imported,
      );
      imported += batch.length;
      batch.clear();
      onProgress?.call(imported, 0);
      await Future<void>.delayed(Duration.zero);
    }

    Future<void> queueCurrentChapter() async {
      if (currentContent.isEmpty) return;
      batch.add(
        ImportChapterDto(
          title: currentChapterTitle,
          content: currentContent.toString(),
        ),
      );
      currentContent = StringBuffer();
      if (batch.length >= _txtBatchSize) {
        await flushBatch();
      }
    }

    try {
      await _bookRepository.createImportedBook(bookEntity);

      final lines = file
          .openRead()
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      var linesSinceYield = 0;
      await for (final rawLine in lines) {
        linesSinceYield++;
        if (linesSinceYield >= _txtYieldEveryLines) {
          linesSinceYield = 0;
          await Future<void>.delayed(Duration.zero);
        }

        final line = rawLine.trim();
        if (line.isEmpty) continue;

        hasAnyContent = true;
        if (chapterRegex.hasMatch(line)) {
          await queueCurrentChapter();
          hasChapterMarker = true;
          currentChapterTitle = _decodeHtmlEntities(line);
        } else {
          currentContent.write('<p>${_escapeParagraphText(line)}</p>');
        }
      }

      if (!hasChapterMarker) {
        currentChapterTitle = 'Toàn văn';
      }

      await queueCurrentChapter();
      await flushBatch();

      if (!hasAnyContent || imported == 0) {
        throw Exception('File rỗng hoặc không đọc được nội dung');
      }

      await _bookRepository.updateImportedBookTotalChapter(
        bookId: bookId,
        totalChapter: imported,
      );
    } catch (_) {
      await _bookRepository.deleteBook(bookId);
      rethrow;
    }

    return bookId;
  }

  Future<ImportBookDto?> _parseEpub(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final epubBook = await EpubReader.readBook(bytes);

      final title = epubBook.Title ?? p.basenameWithoutExtension(file.path);
      final author = epubBook.Author ?? 'Sưu tầm';

      final List<ImportChapterDto> chapters = [];

      Future<void> extractChapters(List<EpubChapter> epubChapters) async {
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
            if (chapters.length % _epubYieldEveryChapters == 0) {
              await Future<void>.delayed(Duration.zero);
            }
          }
          if (epubChapter.SubChapters != null) {
            await extractChapters(epubChapter.SubChapters!);
          }
        }
      }

      await extractChapters(epubBook.Chapters ?? []);

      final thumb = await _saveCoverImageLocal(epubBook.CoverImage, _uuid.v4());
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
        buffer.write('<p>${_escapeParagraphText(cleanLine)}</p>');
      }
    }

    return buffer.toString();
  }

  String _decodeHtmlEntities(String text) {
    return _htmlUnescape.convert(text).replaceAll('\u00A0', ' ').trim();
  }

  String _escapeParagraphText(String text) {
    return _htmlEscape.convert(_decodeHtmlEntities(text));
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
