import 'package:flutter/material.dart';
import 'package:vedio_downloader/features/download_video/models/video_manifest_model.dart';

import '../../../../core/const/const.dart';
import 'file_information_widget.dart';

class MainDownloadScreenWidget extends StatelessWidget {
  const MainDownloadScreenWidget({Key? key, required this.videoMainfest})
      : super(key: key);
  final VideoMainfestModel videoMainfest;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Video',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: videoMainfest.muxed.length,
                itemBuilder: (context, index) {
                  return FileInforMationCardWidget(
                    quality: videoMainfest.muxed[index].qualityLabel,
                    url: videoMainfest.muxed[index].url,
                    fileSize: videoMainfest.muxed[index].size,
                  );
                }),
            const SizedBox(
              height: AppHeight.h20,
            ),
            Text(
              'Audio',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: videoMainfest.audioOnly.length,
              itemBuilder: (context, index) {
                return FileInforMationCardWidget(
                  quality: videoMainfest.audioOnly[index].audioCodec,
                  url: videoMainfest.audioOnly[index].url,
                  fileSize: videoMainfest.audioOnly[index].size,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
