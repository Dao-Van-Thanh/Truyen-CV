import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:truyen_cv/constants/common.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/backup/enum/backup_status.dart';
import 'package:truyen_cv/i18n/strings.g.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  BackupStatus _currentStatus = BackupStatus.idle;
  String? _errorMessage;
  bool _isProcessing = false;

  late final _localApiService = ref.read(AppService.localApi);
  late final _backupService = ref.read(AppService.backup);

  void _updateStatus(BackupStatus status, {String? errorMessage}) {
    if (!mounted) return;
    setState(() {
      _currentStatus = status;
      _errorMessage = errorMessage;
    });
  }

  Future<String> _getDbPath() async {
    final dbFolder = await getDatabasesPath();
    return join(dbFolder, CommonConstants.dbName);
  }

  Future<void> _handleExport() async {
    setState(() => _isProcessing = true);

    try {
      final dbPath = await _getDbPath();
      await _backupService.exportDatabaseZip(
        dbPath: dbPath,
        onProgress: _updateStatus,
      );
    } catch (e) {
      _updateStatus(BackupStatus.exportError, errorMessage: e.toString());
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _handleImport() async {
    final zipPath = await _pickBackupZipFile();
    if (zipPath == null) {
      _updateStatus(BackupStatus.fileSelectionCancelled);
      return;
    }

    final confirm = await _showConfirmOverwriteDialog();
    if (!confirm) {
      _updateStatus(BackupStatus.importCancelled);
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final dbPath = await _getDbPath();

      await _backupService.importDatabaseZip(
        zipFilePath: zipPath,
        targetDbPath: dbPath,
        onProgress: _updateStatus,
        closeDatabase: () async {
          await _localApiService.closeDb();
          _updateStatus(BackupStatus.disconnectingOldDb);
        },
        reopenDatabase: () async {
          await _localApiService.initDb();
          _updateStatus(BackupStatus.connectingNewDb);
        },
      );

      if (mounted && _currentStatus == BackupStatus.importSuccess) {
        await _showSuccessDialog();
      }
    } catch (e) {
      _updateStatus(BackupStatus.importError, errorMessage: e.toString());
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<String?> _pickBackupZipFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    return result?.files.single.path;
  }

  Future<bool> _showConfirmOverwriteDialog() async {
    final tBackup = t.backup;

    final result = await showDialog<bool>(
      context: ref.context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                tBackup.overwriteWarning.title,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          content: Text(tBackup.overwriteWarning.content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                tBackup.overwriteWarning.cancel,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(tBackup.overwriteWarning.confirm),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  Future<void> _showSuccessDialog() async {
    final tBackup = t.backup;

    await showDialog(
      context: ref.context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(tBackup.successDialog.title),
          content: Text(tBackup.successDialog.content),
          actions: [
            ElevatedButton(
              onPressed: () => exit(0),
              child: Text(tBackup.successDialog.understood),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tBackup = context.t.backup;

    final displayText = _errorMessage != null && _currentStatus.isError
        ? '${_currentStatus.message}: $_errorMessage'
        : _currentStatus.message;

    return Scaffold(
      appBar: AppBar(
        title: Text(tBackup.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              _currentStatus.isSuccess
                  ? Icons.cloud_done_rounded
                  : Icons.cloud_sync_rounded,
              size: 80,
              color: _currentStatus.isError ? Colors.red : Colors.blue,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file_rounded),
              label: Text(tBackup.exportBtn),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _isProcessing ? null : _handleExport,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.download_rounded),
              label: Text(tBackup.importBtn),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _isProcessing ? null : _handleImport,
            ),
            const SizedBox(height: 48),
            _buildStatusContainer(context, displayText, tBackup.progressStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusContainer(
    BuildContext context,
    String displayText,
    String progressStatusText,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            progressStatusText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          if (_isProcessing)
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: LinearProgressIndicator(),
            ),
          Text(
            displayText,
            style: TextStyle(
              color: _currentStatus.isError
                  ? Colors.red
                  : (_currentStatus.isSuccess ? Colors.green[700] : null),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
