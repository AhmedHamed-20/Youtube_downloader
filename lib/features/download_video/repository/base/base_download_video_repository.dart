import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:direct_link/direct_link.dart';
import 'package:equatable/equatable.dart';
import 'package:vedio_downloader/core/error/failure.dart';
import 'package:vedio_downloader/features/download_video/models/base_video_information_model.dart';

import '../../../../core/file_downloader_package/base_file_downloader.dart';
import '../../models/video_manifest_model.dart';

abstract class BaseVideoDownloadRepository {
  Future<Either<Failure, BaseVideoInformationModel>> getVideoBaseInformation(
      VideoBaseInforParams params);

  Future<Either<Failure, VideoMainfestModel>> getVideoDownloadMainfest(
      VideoManifestInforParams params);
  Future<Either<Failure, String>> downloadVideo(DonwnloadVideoParams params);
  Future<Either<Failure, SiteModel?>> fileDownloader(String url);
  Future<Either<Failure, Stream<DownloadResult>>> downloadFile(
      String url, String fileName);
}

class DonwnloadVideoParams extends Equatable {
  final String url;
  final String path;
  final String fileName;
  final CancelToken cancelToken;
  final StreamController<double> downloadStreamProgress;
  const DonwnloadVideoParams(
      {required this.url,
      required this.path,
      required this.fileName,
      required this.downloadStreamProgress,
      required this.cancelToken});

  @override
  List<Object?> get props =>
      [url, path, fileName, downloadStreamProgress, cancelToken];
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
