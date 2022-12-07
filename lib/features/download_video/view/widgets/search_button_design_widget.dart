import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';

import '../../../../core/const/text_editing_controllers.dart';
import '../../../../core/widgets/defaults.dart';

class ButtonSearchDesignWidget extends StatelessWidget {
  const ButtonSearchDesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var videoDownloaderCubit = BlocProvider.of<VideoDownloaderCubit>(context);
    return Defaults.defaultButton(
      context: context,
      title: 'Search About Video',
      onPressed: () {
        videoDownloaderCubit
            .getVideoInformation(TextEditingControllers.urlController.text);
      },
    );
  }
}
