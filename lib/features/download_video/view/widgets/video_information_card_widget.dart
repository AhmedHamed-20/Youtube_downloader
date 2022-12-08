import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/core/const/const.dart';
import 'package:vedio_downloader/core/widgets/defaults.dart';

import '../../../../core/utls/utls.dart';
import '../../view_model/cubit/video_downloader_bloc_cubit.dart';
import '../screens/download_screen.dart';

class VideoInformationCardWidget extends StatelessWidget {
  const VideoInformationCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoDownloaderCubit, VideoDownloaderState>(
        builder: (context, state) {
      if (state.videoInformation != null &&
          state.videoInforMattionRequsetStatus ==
              GetVideoInforormationRequestStatus.success) {
        return Card(
          color: AppColors.seconderyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.r25),
                    child: Image.network(
                      errorBuilder: (context, error, stackTrace) => Text(
                        'Error',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppColors.toastError),
                      ),
                      state.videoInformation!.videoThumbnail,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator();
                      },
                    )),
                const SizedBox(height: AppHeight.h10),
                Text(
                  state.videoInformation!.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.black,
                      ),
                ),
                const SizedBox(height: AppHeight.h10),
                Defaults.defaultButton(
                  color: AppColors.seconderyButtonColor,
                  context: context,
                  title: 'Go To Download Page',
                  onPressed: () {
                    navigatePushTo(
                        navigateTO: const DownloadScreen(), context: context);
                  },
                ),
              ],
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
