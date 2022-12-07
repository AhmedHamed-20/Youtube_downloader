import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';

import '../../../../core/const/text_editing_controllers.dart';
import '../../../../core/utls/utls.dart';
import '../widgets/main_download_screen_widget.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VideoDownloaderCubit>(context)
        .getVideoManifest(TextEditingControllers.urlController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Download Screen',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: BlocBuilder<VideoDownloaderCubit, VideoDownloaderState>(
          builder: (context, state) {
            switch (state.videoManifestRequsetStatus) {
              case GetVideoMainfestRequestStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case GetVideoMainfestRequestStatus.success:
                return MainDownloadScreenWidget(
                  videoMainfest: state.videoMainfest!,
                );
              case GetVideoMainfestRequestStatus.error:
                return Center(child: Text(state.errorMessage));
            }
          },
        ));
  }
}
