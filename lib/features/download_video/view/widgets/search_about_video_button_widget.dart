import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/core/const/const.dart';
import 'package:vedio_downloader/features/download_video/view/widgets/search_button_design_widget.dart';
import 'package:vedio_downloader/features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';

import '../../../../core/utls/utls.dart';

class SearchAboutVideoButtonWidget extends StatelessWidget {
  const SearchAboutVideoButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoDownloaderCubit, VideoDownloaderState>(
        listener: (context, state) {
      if (state.videoInforMattionRequsetStatus ==
          GetVideoInforormationRequestStatus.error) {
        flutterToast(
          msg: state.errorMessage,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }, builder: (context, state) {
      switch (state.videoInforMattionRequsetStatus) {
        case GetVideoInforormationRequestStatus.idle:
          return const ButtonSearchDesignWidget();
        case GetVideoInforormationRequestStatus.loading:
          return const Center(child: CircularProgressIndicator());
        case GetVideoInforormationRequestStatus.success:
          return const ButtonSearchDesignWidget();
        case GetVideoInforormationRequestStatus.error:
          return const ButtonSearchDesignWidget();
      }
    });
  }
}
