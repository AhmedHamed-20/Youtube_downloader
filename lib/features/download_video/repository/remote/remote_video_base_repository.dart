import 'package:vedio_downloader/core/youtube_explode/youtube_explode_helper.dart';
import 'package:vedio_downloader/features/download_video/models/base_video_information_model.dart';
import 'package:vedio_downloader/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:vedio_downloader/features/download_video/repository/base/base_download_video_repository.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../models/video_manifest_model.dart';

class RemoteVidoDownloadRepository extends BaseVideoDownloadRepository {
  @override
  Future<Either<Failure, BaseVideoInformationModel>> getVideoBaseInformation(
      VideoBaseInforParams params) async {
    try {
      final video = await YoutubeExplodeHelper.getVideo(params.url);
      return Right(BaseVideoInformationModel.fromVideo(video));
    } on YoutubeExplodeException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, VideoMainfestModel>> getVideoDownloadMainfest(
      VideoManifestInforParams params) async {
    try {
      final streamManifest =
          await YoutubeExplodeHelper.getStreamManifest(params.url);
      return Right(VideoMainfestModel.fromStreamManifest(streamManifest));
    } on YoutubeExplodeException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
