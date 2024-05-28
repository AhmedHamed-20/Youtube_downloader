part of 'video_downloader_bloc_cubit.dart';

class VideoDownloaderState extends Equatable {
  final BaseVideoInformationModel? videoInformation;
  final String errorMessage;
  final VideoMainfestModel? videoMainfest;
  final GetVideoInforormationRequestStatus videoInforMattionRequsetStatus;
  final GetVideoMainfestRequestStatus videoManifestRequsetStatus;
  final DownloadVideoRequestStatus downloadVideoRequestStatus;
  final SiteModel? siteModel;
  const VideoDownloaderState({
    this.videoInformation,
    this.errorMessage = '',
    this.videoMainfest,
    this.siteModel,
    this.downloadVideoRequestStatus = DownloadVideoRequestStatus.idle,
    this.videoManifestRequsetStatus = GetVideoMainfestRequestStatus.loading,
    this.videoInforMattionRequsetStatus =
        GetVideoInforormationRequestStatus.idle,
  });

  VideoDownloaderState copyWith({
    SiteModel? siteModel,
    DownloadVideoRequestStatus? downloadVideoRequestStatus,
    GetVideoMainfestRequestStatus? videoManifestRequsetStatus,
    VideoMainfestModel? videoMainfest,
    BaseVideoInformationModel? videoInformation,
    String? errorMessage,
    GetVideoInforormationRequestStatus? videoInforMattionRequsetStatus,
  }) {
    return VideoDownloaderState(
      siteModel: siteModel ?? this.siteModel,
      downloadVideoRequestStatus:
          downloadVideoRequestStatus ?? this.downloadVideoRequestStatus,
      videoMainfest: videoMainfest ?? this.videoMainfest,
      videoManifestRequsetStatus:
          videoManifestRequsetStatus ?? this.videoManifestRequsetStatus,
      videoInformation: videoInformation ?? this.videoInformation,
      errorMessage: errorMessage ?? this.errorMessage,
      videoInforMattionRequsetStatus:
          videoInforMattionRequsetStatus ?? this.videoInforMattionRequsetStatus,
    );
  }

  @override
  List<Object?> get props => [
        videoInformation,
        siteModel,
        downloadVideoRequestStatus,
        errorMessage,
        videoInforMattionRequsetStatus,
        videoMainfest,
        videoManifestRequsetStatus
      ];
}
