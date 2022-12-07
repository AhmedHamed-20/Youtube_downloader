import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vedio_downloader/core/error/failure.dart';
import 'package:vedio_downloader/features/download_video/models/base_video_information_model.dart';

import '../../models/video_manifest_model.dart';

abstract class BaseVideoDownloadRepository {
  Future<Either<Failure, BaseVideoInformationModel>> getVideoBaseInformation(
      VideoBaseInforParams params);

  Future<Either<Failure, VideoMainfestModel>> getVideoDownloadMainfest(
      VideoManifestInforParams params);
}

class VideoBaseInforParams extends Equatable {
  final String url;

  const VideoBaseInforParams({required this.url});

  @override
  List<Object?> get props => [url];
}

class VideoManifestInforParams extends Equatable {
  final String url;

  const VideoManifestInforParams({required this.url});

  @override
  List<Object?> get props => [url];
}
