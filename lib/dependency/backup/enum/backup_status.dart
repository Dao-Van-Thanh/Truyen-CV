// file: lib/dependency/backup/enum/backup_status.dart

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
        return 'Sẵn sàng';
      case BackupStatus.preparingExport:
        return 'Đang chuẩn bị dữ liệu...';
      case BackupStatus.compressing:
        return 'Đang nén dữ liệu...';
      case BackupStatus.savingFile:
        return 'Đang mở hộp thoại lưu file...';
      case BackupStatus.exportSuccess:
        return 'Sao lưu thành công!';
      case BackupStatus.exportCancelled:
        return 'Đã hủy sao lưu.';
      case BackupStatus.exportError:
        return 'Lỗi sao lưu';
      case BackupStatus.checkingFile:
        return 'Đang kiểm tra file...';
      case BackupStatus.fileSelectionCancelled:
        return 'Đã hủy chọn file.';
      case BackupStatus.importCancelled:
        return 'Đã hủy khôi phục dữ liệu.';
      case BackupStatus.invalidFile:
        return 'File backup không hợp lệ hoặc sai định dạng!';
      case BackupStatus.disconnectingOldDb:
        return 'Đã ngắt kết nối DB cũ...';
      case BackupStatus.connectingNewDb:
        return 'Đã kết nối lại DB mới...';
      case BackupStatus.restoringData:
        return 'Đang khôi phục dữ liệu...';
      case BackupStatus.importSuccess:
        return 'Khôi phục thành công! Vui lòng khởi động lại app.';
      case BackupStatus.importError:
        return 'Lỗi khôi phục';
      case BackupStatus.requireAppUpdate:
        return 'Bản sao lưu thuộc về phiên bản ứng dụng mới hơn. Vui lòng cập nhật ứng dụng!';
    }
  }

  bool get isError =>
      this == BackupStatus.exportError ||
      this == BackupStatus.importError ||
      this == BackupStatus.invalidFile;
  bool get isSuccess =>
      this == BackupStatus.exportSuccess || this == BackupStatus.importSuccess;
}
