import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/core/const/const.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../view_model/cubit/video_downloader_bloc_cubit.dart';

class FileInforMationCardWidget extends StatelessWidget {
  const FileInforMationCardWidget(
      {super.key,
      required this.quality,
      required this.url,
      required this.subtype,
      required this.videoName,
      required this.fileSize});
  final String quality;
  final Uri url;
  final FileSize fileSize;
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
        title: Text(
          quality,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColors.black),
        ),
        subtitle: Text(
          fileSize.toString(),
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
        ),
        trailing: TextButton(
          child: Text(
            'Download',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.seconderyButtonColor),
          ),
          onPressed: () async {
            // Directory appDocDir = await getApplicationDocumentsDirectory();
            // String appDocPath = appDocDir.path;
            final directory = Directory('/storage/emulated/0/Download');
            //print(url.fragment);
            final file = File('${directory.path}/$videoName.$subtype');

            downloadBloc.downloadVideo(
              cancelToken: cancelToken,
              url: url.toString(),
              path: file.path,
              fileName: 'video',
              downloadProgress: downloadProgress,
            );
          },
        ),
      ),
    );
  }
}
