import 'package:flutter/material.dart';
import 'package:vedio_downloader/core/const/const.dart';

import '../../../../core/const/text_editing_controllers.dart';
import '../../../../core/widgets/defaults.dart';
import '../widgets/search_about_video_button_widget.dart';
import '../widgets/video_information_card_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube Downloader',
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            children: [
              Image.asset('assets/images/logo.gif'),
              const SizedBox(
                height: AppHeight.h10,
              ),
              Defaults.defaultTextField(
                context: context,
                prefixIcon: const Icon(Icons.text_fields),
                controller: TextEditingControllers.urlController,
                title: 'Enter URL',
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              const VideoInformationCardWidget(),
              const SizedBox(
                height: AppHeight.h20,
              ),
              const SearchAboutVideoButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
