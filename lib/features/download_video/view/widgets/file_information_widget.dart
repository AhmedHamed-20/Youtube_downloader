import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/core/const/const.dart';

import '../../view_model/cubit/video_downloader_bloc_cubit.dart';

class FileInforMationCardWidget extends StatelessWidget {
  const FileInforMationCardWidget({
    super.key,
    required this.quality,
    required this.url,
    required this.subtype,
    required this.videoName,
  });
  final String quality;
  final String url;
  final String subtype;
  final String videoName;
  @override
  Widget build(BuildContext context) {
    final downloadBloc = BlocProvider.of<VideoDownloaderCubit>(context);
    return Card(
      color: AppColors.seconderyColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r25),
      ),
      child: ListTile(
        title: Row(
          children: [
            Text(
              'Quality: ',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.black),
            ),
            Text(
              quality,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.black),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Text(
              'Type: ',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.black),
            ),
            Text(
              subtype,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.black),
            ),
          ],
        ),
        trailing: TextButton(
          child: Text(
            'Download',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppColors.seconderyButtonColor),
          ),
          onPressed: () async {
            // final directory =
            //     Directory('/storage/emulated/0/Youtube Downloader');
            // final removeOrSymbole = videoName.replaceAll('|', '');
            // final fileName = removeOrSymbole.replaceAll('/', '');
            // final file = File('${directory.path}/($fileName).$subtype');
            downloadBloc.fileDownloader(url, videoName);
          },
        ),
      ),
    );
  }
}
