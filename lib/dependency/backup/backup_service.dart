import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/dependency/backup/enum/backup_status.dart';
import 'package:flutter_template/dependency/sqflite/sqlite_service.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

bool _isBackupVersionNewer(String backupVer, String currentVer) {
  try {
    final v1 = backupVer.split('+')[0].split('.');
    final v2 = currentVer.split('+')[0].split('.');

    for (var i = 0; i < 3; i++) {
      final num1 = i < v1.length ? int.tryParse(v1[i]) ?? 0 : 0;
      final num2 = i < v2.length ? int.tryParse(v2[i]) ?? 0 : 0;
      if (num1 > num2) return true; // Backup mới hơn
      if (num1 < num2) return false; // App mới hơn
    }
    return false;
  } catch (e) {
    logger.e('Lỗi khi check version: $e');
    return false;
  }
}

void _compressFilesIsolate(Map<String, dynamic> args) {
  final filePaths = args['files'] as List<String>;
  final zipPath = args['zipPath'] as String;
  final manifestKey = args['manifestKey'] as String;
  final dbVersion = args['dbVersion'] as int;

  final archive = Archive();

  final manifestData = jsonEncode(
    {'app': 'TruyenCV', 'key': manifestKey, 'dbVersion': dbVersion},
  );
  final manifestBytes = utf8.encode(manifestData);
  archive.addFile(
    ArchiveFile('manifest.json', manifestBytes.length, manifestBytes),
  );

  for (final path in filePaths) {
    final file = File(path);
    final bytes = file.readAsBytesSync();
    archive.addFile(ArchiveFile(p.basename(path), bytes.length, bytes));
  }

  final zipData = ZipEncoder().encode(archive);
  if (zipData != null) File(zipPath).writeAsBytesSync(zipData);
}

// 0: Thành công
// 1: File hỏng / Sai Key
// 2: Cần cập nhật App
int _extractAndValidateIsolate(Map<String, dynamic> args) {
  final zipPath = args['zipPath'] as String;
  final extractPath = args['extractPath'] as String;
  final manifestKey = args['manifestKey'] as String;
  final dbFileName = args['dbFileName'] as String;
  final dbVersion = args['dbVersion'] as int;

  final bytes = File(zipPath).readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);

  final manifestFile = archive.findFile('manifest.json');
  if (manifestFile == null) return 1;

  final manifestJson =
      jsonDecode(utf8.decode(manifestFile.content as List<int>));

  if (manifestJson['key'] != manifestKey) return 1;

  // XỬ LÝ SO SÁNH DB VERSION
  final backupVersion = manifestJson['dbVersion'] as int? ?? 1;
  if (dbVersion > backupVersion) {
    return 2; // Cần update app
  }

  final dir = Directory(extractPath);
  if (!dir.existsSync()) dir.createSync(recursive: true);

  for (final file in archive) {
    if (file.isFile && file.name.startsWith(dbFileName)) {
      File(p.join(extractPath, file.name))
          .writeAsBytesSync(file.content as List<int>);
    }
  }
  return 0; // Hợp lệ, đã giải nén xong
}

class BackupService {
  final String _manifestKey = 'TRUYENCV_BACKUP_VALID_KEY';

  Future<void> exportDatabaseZip({
    required String dbPath,
    required Function(BackupStatus status, {String? errorMessage}) onProgress,
  }) async {
    try {
      onProgress(BackupStatus.preparingExport);

      final filesToBackup = [
        File(dbPath),
        File('$dbPath-wal'),
        File('$dbPath-shm'),
      ].where((f) => f.existsSync()).toList();

      if (filesToBackup.isEmpty) {
        throw Exception('Không tìm thấy Database.');
      }

      onProgress(BackupStatus.compressing);
      final tempDir = await getTemporaryDirectory();

      final fileName =
          'truyencv_backup_${DateTime.now().millisecondsSinceEpoch}.zip';
      final zipFilePath = p.join(tempDir.path, fileName);

      await compute(_compressFilesIsolate, {
        'files': filesToBackup.map((f) => f.path).toList(),
        'zipPath': zipFilePath,
        'manifestKey': _manifestKey,
        'dbVersion': sqliteVersion,
      });

      onProgress(BackupStatus.savingFile);

      if (Platform.isAndroid) {
        final fileBytes = await File(zipFilePath).readAsBytes();

        final String? outputFile = await FilePicker.platform.saveFile(
          dialogTitle: 'Chọn thư mục để lưu bản sao lưu',
          fileName: fileName,
          type: FileType.custom,
          allowedExtensions: ['zip'],
          bytes: fileBytes,
        );

        if (outputFile != null) {
          onProgress(BackupStatus.exportSuccess);
        } else {
          onProgress(BackupStatus.exportCancelled);
        }
      } else {
        final result = await SharePlus.instance.share(
          ShareParams(
            files: [XFile(zipFilePath)],
          ),
        );

        if (result.status == ShareResultStatus.success) {
          onProgress(BackupStatus.exportSuccess);
        } else {
          onProgress(BackupStatus.exportCancelled);
        }
      }
    } catch (e) {
      logger.e('Error exporting database: $e');
      onProgress(BackupStatus.exportError, errorMessage: e.toString());
    }
  }

  Future<void> importDatabaseZip({
    required String zipFilePath,
    required String targetDbPath,
    required Function(BackupStatus status, {String? errorMessage}) onProgress,
    required Future<void> Function() closeDatabase,
    required Future<void> Function() reopenDatabase,
  }) async {
    try {
      onProgress(BackupStatus.checkingFile);

      final tempDir = await getTemporaryDirectory();
      final tempExtractPath = p.join(tempDir.path, 'extracted_db');
      final dbFileName = p.basename(targetDbPath);

      // Nhận mã kết quả từ Isolate
      final validationCode = await compute(_extractAndValidateIsolate, {
        'zipPath': zipFilePath,
        'extractPath': tempExtractPath,
        'manifestKey': _manifestKey,
        'dbFileName': dbFileName,
        'dbVersion': sqliteVersion,
      });

      // Kiểm tra mã lỗi
      if (validationCode == 1) {
        onProgress(BackupStatus.invalidFile);
        return;
      } else if (validationCode == 2) {
        onProgress(BackupStatus.requireAppUpdate); // Báo lỗi version
        return;
      }

      onProgress(BackupStatus.restoringData);
      await closeDatabase();

      final targetDir = p.dirname(targetDbPath);
      final filesToRestore = [
        dbFileName,
        '$dbFileName-wal',
        '$dbFileName-shm',
      ];

      for (final fileName in filesToRestore) {
        final extractedFile = File(p.join(tempExtractPath, fileName));
        final targetFile = File(p.join(targetDir, fileName));

        if (extractedFile.existsSync()) {
          if (targetFile.existsSync()) targetFile.deleteSync();
          extractedFile.copySync(targetFile.path);
        } else if (targetFile.existsSync() && fileName != dbFileName) {
          targetFile.deleteSync();
        }
      }

      await reopenDatabase();
      onProgress(BackupStatus.importSuccess);
    } catch (e) {
      onProgress(BackupStatus.importError, errorMessage: e.toString());
    }
  }
}
