import 'package:flutter/material.dart';
import 'package:vedio_downloader/core/const/const.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class FileInforMationCardWidget extends StatelessWidget {
  const FileInforMationCardWidget(
      {super.key,
      required this.quality,
      required this.url,
      required this.fileSize});
  final String quality;
  final Uri url;
  final FileSize fileSize;
  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
        ),
      ),
    );
  }
}
