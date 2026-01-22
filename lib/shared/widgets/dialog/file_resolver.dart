import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uri_to_file/uri_to_file.dart';

class FileResolver {
  static Future<File> resolveToLocalFile(String uriString) async {
    if (!Platform.isAndroid) {
      final file = File(uriString);
      if (await file.exists()) return file;
      throw Exception('File không tồn tại (iOS)');
    }

    if (uriString.startsWith('/document/raw:')) {
      final path = uriString.replaceFirst('/document/raw:', '');
      return File(path);
    }

    if (uriString.startsWith('file://')) {
      return File(uriString.replaceFirst('file://', ''));
    }

    return _copyFromSaf(uriString);
  }

  static Future<File> _copyFromSaf(String uriString) async {
    final uri = Uri.parse(
      uriString.startsWith('/')
          ? 'content://com.android.externalstorage.documents$uriString'
          : uriString,
    );

    final bytes = await _readBytesFromUri(uri);
    if (bytes == null) {
      throw Exception('Không đọc được dữ liệu từ SAF');
    }

    final dir = await getApplicationDocumentsDirectory();

    final ext = _guessExtension(bytes);
    final fileName = 'import_${DateTime.now().millisecondsSinceEpoch}$ext';

    final file = File(p.join(dir.path, fileName));
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<Uint8List?> _readBytesFromUri(Uri uri) async {
    final data = await compute(_readInIsolate, uri.toString());
    return data;
  }

  static Future<Uint8List?> _readInIsolate(String uriString) async {
    try {
      final file = await toFile(uriString);
      return await file.readAsBytes();
    } catch (_) {
      return null;
    }
  }

  static String _guessExtension(Uint8List bytes) {
    final mime = lookupMimeType('', headerBytes: bytes);
    if (mime == 'application/epub+zip') return '.epub';
    if (mime == 'text/plain') return '.txt';
    return '';
  }

  const FileResolver();
}
