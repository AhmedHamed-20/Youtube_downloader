import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'base_file_downloader.dart';

class FileDownloaderImpl extends FileDownloader {
  late FileDownloader _downloaderDelegate;

  FileDownloaderImpl._(FileDownloader downloaderDelegate) {
    _downloaderDelegate = downloaderDelegate;
  }

  static FutureOr<FileDownloader> createInstance() async {
    return FileDownloaderImpl._(Platform.isAndroid
        ? await _AndroidDownloadDelegate.createInstance()
        : _OtherDownloadDelegate());
  }

  @override
  Stream<DownloadResult> downloadFile(String fileLink, String fileName) async* {
    yield* _downloaderDelegate.downloadFile(fileLink, fileName);
  }
}

class _AndroidDownloadDelegate extends FileDownloader {
  static Future<FileDownloader> createInstance() async {
    await FlutterDownloader.initialize(
      debug: true,
    );
    return _AndroidDownloadDelegate._();
  }

  static late Map<String, ReceivePort> _currentOpenedPorts;
  static late Map<DownloadTaskStatus, DownloadStatus> _downloadStatusMap;

  _AndroidDownloadDelegate._() {
    _currentOpenedPorts = <String, ReceivePort>{};
    _downloadStatusMap = {
      DownloadTaskStatus.failed: DownloadStatus.failed,
      DownloadTaskStatus.complete: DownloadStatus.Completed,
      DownloadTaskStatus.running: DownloadStatus.Running,
      DownloadTaskStatus.enqueued: DownloadStatus.Pending,
    };
  }

  @override
  Stream<DownloadResult> downloadFile(String fileLink, String fileName) async* {
    PermissionStatus status = await Permission.storage.request();
    if (![PermissionStatus.limited, PermissionStatus.granted].contains(status))
      yield DownloadResult();
    FlutterDownloader.registerCallback(_downloadCallback);
    String? taskId = await FlutterDownloader.enqueue(
      url: fileLink,
      savedDir: await _getSavePath(),
      fileName: fileName,
      showNotification: true,
      saveInPublicStorage: true,
      openFileFromNotification: true,
      requiresStorageNotLow: true,
    );
    if (taskId == null) yield DownloadResult();
    _currentOpenedPorts[taskId!] = ReceivePort();
    yield* _downloadResultInStream(taskId);
    _currentOpenedPorts.remove(taskId);
  }

  static void _downloadCallback(String id, int status, int progress) {
    _currentOpenedPorts[id]?.sendPort.send([status, progress]);
  }

  Future<String> _getSavePath() async {
    if (Platform.isAndroid)
      return (await getExternalStorageDirectories(
              type: StorageDirectory.downloads))!
          .first
          .path;
    return (await getApplicationDocumentsDirectory()).path;
  }

  String _fileName(String fileLink) {
    String fileNameWithExtension = fileLink.split("/").last;
    return fileNameWithExtension;
  }

  Stream<DownloadResult> _downloadResultInStream(String taskId) async* {
    await for (var message in _currentOpenedPorts[taskId]!) {
      yield DownloadResult(
          progress: message[1], status: _downloadStatusMap[message[0]]!);
      if (message[1] == 100) return;
    }
  }
}

class _OtherDownloadDelegate extends FileDownloader {
  @override
  Stream<DownloadResult> downloadFile(String fileLink, String fileName) async* {
    if (await canLaunchUrl(Uri.parse(fileLink))) {
      await launchUrl(Uri.parse(fileLink));
      yield DownloadResult(status: DownloadStatus.Completed, progress: 100);
    }
    yield DownloadResult();
  }
}
