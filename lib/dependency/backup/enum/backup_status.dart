import 'package:flutter_template/i18n/strings.g.dart';

enum BackupStatus {
  idle, // Trạng thái ban đầu: Sẵn sàng

  // Trạng thái Export
  preparingExport,
  compressing,
  savingFile,
  exportSuccess,
  exportCancelled,
  exportError,

  // Trạng thái Import
  fileSelectionCancelled, // Hủy lúc chọn file
  importCancelled, // Hủy ở popup xác nhận
  checkingFile,
  invalidFile,
  disconnectingOldDb, // Đang ngắt DB cũ
  connectingNewDb, // Đang nối lại DB mới
  restoringData,
  importSuccess,
  importError,

  requireAppUpdate,
}

extension BackupStatusExtension on BackupStatus {
  String get message {
    switch (this) {
      case BackupStatus.idle:
        return t.backup.status.idle;
      case BackupStatus.preparingExport:
        return t.backup.status.preparingExport;
      case BackupStatus.compressing:
        return t.backup.status.compressing;
      case BackupStatus.savingFile:
        return t.backup.status.savingFile;
      case BackupStatus.exportSuccess:
        return t.backup.status.exportSuccess;
      case BackupStatus.exportCancelled:
        return t.backup.status.exportCancelled;
      case BackupStatus.exportError:
        return t.backup.status.exportError;
      case BackupStatus.checkingFile:
        return t.backup.status.checkingFile;
      case BackupStatus.fileSelectionCancelled:
        return t.backup.status.fileSelectionCancelled;
      case BackupStatus.importCancelled:
        return t.backup.status.importCancelled;
      case BackupStatus.invalidFile:
        return t.backup.status.invalidFile;
      case BackupStatus.disconnectingOldDb:
        return t.backup.status.disconnectingOldDb;
      case BackupStatus.connectingNewDb:
        return t.backup.status.connectingNewDb;
      case BackupStatus.restoringData:
        return t.backup.status.restoringData;
      case BackupStatus.importSuccess:
        return t.backup.status.importSuccess;
      case BackupStatus.importError:
        return t.backup.status.importError;
      case BackupStatus.requireAppUpdate:
        return t.backup.status.requireAppUpdate;
    }
  }

  bool get isError =>
      this == BackupStatus.exportError ||
      this == BackupStatus.importError ||
      this == BackupStatus.invalidFile;
      
  bool get isSuccess =>
      this == BackupStatus.exportSuccess || 
      this == BackupStatus.importSuccess;
}