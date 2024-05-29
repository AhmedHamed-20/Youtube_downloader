import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:vedio_downloader/core/network/dio.dart';
import 'package:vedio_downloader/core/services/service_locator.dart';
import 'package:vedio_downloader/core/youtube_explode/youtube_explode_helper.dart';

import 'core/const/text_editing_controllers.dart';
import 'core/theme/app_theme.dart';
import 'features/download_video/view/screens/main_screen.dart';
import 'features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  await ServiceLocator.fileDownloaderDi();
  DioHelper.init();
  YoutubeExplodeHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _intentSub;
  final _sharedFiles = <SharedMediaFile>[];
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();

    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        if (_sharedFiles.isNotEmpty) {
          TextEditingControllers.urlController.text = _sharedFiles[0].path;
        }
        // print(_sharedFiles.map((f) => f.toMap()));
      });
    }, onError: (err) {});
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        // print(_sharedFiles.map((f) => f.toMap()));
        if (_sharedFiles.isNotEmpty) {
          TextEditingControllers.urlController.text = _sharedFiles[0].path;
        }

        // Tell the library that we are done processing the intent.
        ReceiveSharingIntent.instance.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<VideoDownloaderCubit>()),
      ],
      child: MaterialApp(
        title: 'Youtube Downloader',
        theme: AppTheme.lightMode,
        darkTheme: AppTheme.darkMode,
        themeMode: ThemeMode.dark,
        home: const MainScreen(),
      ),
    );
  }
}
