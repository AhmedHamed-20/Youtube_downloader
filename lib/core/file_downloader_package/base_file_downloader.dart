abstract class FileDownloader {
  Stream<DownloadResult> downloadFile(String link, String fileName);
}

enum DownloadStatus { failed, Pending, Running, Completed }

class DownloadResult {
  final DownloadStatus status;
  final int progress;

  DownloadResult({
    this.status = DownloadStatus.failed,
    this.progress = 0,
  });

  @override
  bool operator ==(Object other) {
    if (other is! DownloadResult) return false;
    return status == other.status && progress == other.progress;
  }
}
