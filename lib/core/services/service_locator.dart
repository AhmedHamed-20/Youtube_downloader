import 'package:get_it/get_it.dart';
import 'package:vedio_downloader/features/download_video/repository/base/base_download_video_repository.dart';
import 'package:vedio_downloader/features/download_video/repository/remote/remote_video_base_repository.dart';

import '../../features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';

var serviceLocator = GetIt.instance;

class ServiceLocator {
  static void init() {
    //cubits
    serviceLocator.registerFactory<VideoDownloaderCubit>(
        () => VideoDownloaderCubit(serviceLocator()));
    //repositories

    serviceLocator.registerLazySingleton<BaseVideoDownloadRepository>(
        () => RemoteVidoDownloadRepository());
  }
}
