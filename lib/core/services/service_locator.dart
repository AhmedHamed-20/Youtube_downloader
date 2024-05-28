import 'package:get_it/get_it.dart';
import 'package:vedio_downloader/core/file_checker/file_checker_impl.dart';
import 'package:vedio_downloader/features/download_video/repository/base/base_download_video_repository.dart';
import 'package:vedio_downloader/features/download_video/repository/remote/remote_video_base_repository.dart';
import 'package:vedio_downloader/core/file_downloader_package/file_downloader_impl.dart';

import '../../features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';
import '../file_downloader_package/base_file_downloader.dart';

var serviceLocator = GetIt.instance;

class ServiceLocator {
  static void init() {
    //cubits
    serviceLocator.registerFactory<VideoDownloaderCubit>(
        () => VideoDownloaderCubit(serviceLocator()));
    //repositories

    serviceLocator.registerLazySingleton<BaseVideoDownloadRepository>(
        () => RemoteVidoDownloadRepository());

    serviceLocator.registerLazySingleton<FileChecker>(() => FileChecker());
  }

  static Future<void> fileDownloaderDi() async {
    var downloaderInstance = await FileDownloaderImpl.createInstance();
    serviceLocator
        .registerLazySingleton<FileDownloader>(() => downloaderInstance);
  }
}
