import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/core/const/const.dart';
import 'package:vedio_downloader/features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';

import '../../../../core/const/text_editing_controllers.dart';
import '../../../../core/utls/utls.dart';
import '../widgets/download_alert_dialog_widget.dart';
import '../widgets/main_download_screen_widget.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VideoDownloaderCubit>(context)
        .getVideoManifest(TextEditingControllers.urlController.text);
    downloadProgress = StreamController<double>();
    cancelToken = CancelToken();
  }

  @override
  void dispose() {
    downloadProgress.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Download Screen',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: BlocConsumer<VideoDownloaderCubit, VideoDownloaderState>(
          listener: (context, state) async {
            if (state.downloadVideoRequestStatus ==
                DownloadVideoRequestStatus.loading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const DownloadAlertDialogWidget();
                  });
            }
          },
          builder: (context, state) {
            switch (state.videoManifestRequsetStatus) {
              case GetVideoMainfestRequestStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case GetVideoMainfestRequestStatus.success:
                return MainDownloadScreenWidget(
                  videoMainfest: state.videoMainfest!,
                  videoName: state.videoInformation!.title,
                );
              case GetVideoMainfestRequestStatus.error:
                return Center(child: Text(state.errorMessage));
            }
          },
        ));
  }
}
