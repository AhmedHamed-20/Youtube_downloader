import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:direct_link/direct_link.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vedio_downloader/core/const/const.dart';
import 'package:vedio_downloader/features/download_video/models/base_video_information_model.dart';
import 'package:vedio_downloader/features/download_video/repository/base/base_download_video_repository.dart';

import '../../../../core/file_downloader_package/base_file_downloader.dart';
import '../../../../core/utls/utls.dart';
import '../../models/video_manifest_model.dart';

part 'video_downloader_bloc_state.dart';

class VideoDownloaderCubit extends Cubit<VideoDownloaderState> {
  VideoDownloaderCubit(this.baseVideoDownloadRepository)
      : super(const VideoDownloaderState());

  final BaseVideoDownloadRepository baseVideoDownloadRepository;
  final formKey = GlobalKey<FormState>();
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

  Future<bool> checkPermissions() async {
    bool isPermissionGranted = false;
    if (await getAndroidVersion() > 29) {
      if (await Permission.storage.isGranted &&
          await Permission.accessMediaLocation.isGranted &&
          await Permission.manageExternalStorage.isGranted) {
        isPermissionGranted = true;
      } else {
        await Permission.storage.request();
        await Permission.accessMediaLocation.request();
        await Permission.manageExternalStorage.request();
      }
    } else {
      if (await Permission.storage.isGranted &&
          await Permission.accessMediaLocation.isGranted) {
        isPermissionGranted = true;
      } else {
        await Permission.storage.request();
        await Permission.accessMediaLocation.request();
      }
    }
    return isPermissionGranted;
  }

  Future<int> getAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }

  Future<void> downloadVideo(
      {required String url,
      required String path,
      required String fileName,
      required StreamController<double> downloadProgress,
      required CancelToken cancelToken}) async {
    if (await checkPermissions()) {
      emit(state.copyWith(
          downloadVideoRequestStatus: DownloadVideoRequestStatus.loading));
      final result = await baseVideoDownloadRepository.downloadVideo(
          DonwnloadVideoParams(
              url: url,
              path: path,
              fileName: fileName,
              downloadStreamProgress: downloadProgress,
              cancelToken: cancelToken));

      result.fold(
          (l) => emit(
                state.copyWith(
                  errorMessage: l.message,
                  downloadVideoRequestStatus: DownloadVideoRequestStatus.error,
                ),
              ), (r) {
        return emit(
          state.copyWith(
            errorMessage: '',
            downloadVideoRequestStatus: DownloadVideoRequestStatus.success,
          ),
        );
      });
    } else {
      flutterToast(
          msg: 'Please Accept All Permissions',
          backgroundColor: AppColors.toastError,
          textColor: AppColors.white);
    }
  }

  String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter url';
    }
    return null;
  }

  Future<void> fileChecker(String url) async {
    emit(state.copyWith(
        videoInforMattionRequsetStatus:
            GetVideoInforormationRequestStatus.loading));
    final result = await baseVideoDownloadRepository.fileDownloader(url);
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
          videoInformation: BaseVideoInformationModel(
              title: r!.title!,
              description: r.thumbnail!,
              url: url,
              videoThumbnail: r.thumbnail!),
          siteModel: r,
          videoInforMattionRequsetStatus:
              GetVideoInforormationRequestStatus.success,
        ),
      ),
    );
  }

  Future<void> fileDownloader(String url, String fileName) async {
    flutterToast(
        msg: 'Download started look at notification bar',
        backgroundColor: Colors.green,
        textColor: Colors.white);
    final result =
        await baseVideoDownloadRepository.downloadFile(url, fileName);
    result.fold((l) {
      flutterToast(
          msg: l.message, backgroundColor: Colors.red, textColor: Colors.white);
    }, (r) {
      r.listen((event) {
        if (event.status == DownloadStatus.Completed) {
          flutterToast(
              msg: 'Download Completed',
              backgroundColor: Colors.green,
              textColor: Colors.white);
        }

        if (event.status == DownloadStatus.failed) {
          flutterToast(
              msg: 'Download Failed',
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
      });
    });
  }
}
