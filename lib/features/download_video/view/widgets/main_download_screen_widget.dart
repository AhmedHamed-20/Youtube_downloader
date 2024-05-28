import 'package:direct_link/direct_link.dart';
import 'package:flutter/material.dart';
import 'package:vedio_downloader/features/download_video/models/video_manifest_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../core/const/const.dart';
import 'file_information_widget.dart';

class MainDownloadScreenWidget extends StatelessWidget {
  const MainDownloadScreenWidget(
      {Key? key,
      //   required this.videoMainfest,
      required this.videoName,
      this.siteModel})
      : super(key: key);
  // final VideoMainfestModel videoMainfest;
  final String videoName;
  final SiteModel? siteModel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: siteModel!.links!.length,
                itemBuilder: (context, index) {
                  return FileInforMationCardWidget(
                    videoName: siteModel!.title!,
                    quality: siteModel!.links![index].quality!,
                    url: siteModel!.links![index].link,
                    subtype: siteModel!.links![index].type!,
                  );
                }),
            const SizedBox(
              height: AppHeight.h20,
            ),
          ],
        ),
      ),
    );
  }
}
