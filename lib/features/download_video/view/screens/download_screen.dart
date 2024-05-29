import 'package:direct_link/direct_link.dart';
import 'package:flutter/material.dart';

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
