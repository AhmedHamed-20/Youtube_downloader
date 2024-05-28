import 'dart:async';

import 'package:dio/dio.dart';
import 'package:direct_link/direct_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/core/const/const.dart';
import 'package:vedio_downloader/features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';

import '../../../../core/const/text_editing_controllers.dart';
import '../../../../core/utls/utls.dart';
import '../widgets/download_alert_dialog_widget.dart';
import '../widgets/main_download_screen_widget.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key, this.siteModel});
  final SiteModel? siteModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Download Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: MainDownloadScreenWidget(
        siteModel: siteModel,
        //   videoMainfest: state.videoMainfest!,
        videoName: siteModel!.title!,
      ),
    );
  }
}
