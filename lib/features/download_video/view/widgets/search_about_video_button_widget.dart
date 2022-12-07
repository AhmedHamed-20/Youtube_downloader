import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/features/download_video/view/widgets/search_button_design_widget.dart';
import 'package:vedio_downloader/features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';

import '../../../../core/utls/utls.dart';

class SearchAboutVideoButtonWidget extends StatelessWidget {
  const SearchAboutVideoButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoDownloaderCubit, VideoDownloaderState>(
        builder: (context, state) {
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
