import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vedio_downloader/features/download_video/models/base_video_information_model.dart';
import 'package:vedio_downloader/features/download_video/repository/base/base_download_video_repository.dart';

import '../../../../core/utls/utls.dart';
import '../../models/video_manifest_model.dart';

part 'video_downloader_bloc_state.dart';

class VideoDownloaderCubit extends Cubit<VideoDownloaderState> {
  VideoDownloaderCubit(this.baseVideoDownloadRepository)
      : super(const VideoDownloaderState());

  final BaseVideoDownloadRepository baseVideoDownloadRepository;

  Future<void> getVideoInformation(String url) async {
    emit(state.copyWith(
        videoInforMattionRequsetStatus:
            GetVideoInforormationRequestStatus.loading));
    final result = await baseVideoDownloadRepository
        .getVideoBaseInformation(VideoBaseInforParams(url: url));
    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          videoInforMattionRequsetStatus:
              GetVideoInforormationRequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          videoInformation: r,
          errorMessage: '',
          videoInforMattionRequsetStatus:
              GetVideoInforormationRequestStatus.success,
        ),
      ),
    );
  }

  Future<void> getVideoManifest(String url) async {
    emit(state.copyWith(
        videoManifestRequsetStatus: GetVideoMainfestRequestStatus.loading));
    final result = await baseVideoDownloadRepository
        .getVideoDownloadMainfest(VideoManifestInforParams(url: url));
    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          videoManifestRequsetStatus: GetVideoMainfestRequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          videoMainfest: r,
          errorMessage: '',
          videoManifestRequsetStatus: GetVideoMainfestRequestStatus.success,
        ),
      ),
    );
  }
}
