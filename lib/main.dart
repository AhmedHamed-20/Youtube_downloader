import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedio_downloader/core/network/dio.dart';
import 'package:vedio_downloader/core/services/service_locator.dart';
import 'package:vedio_downloader/core/youtube_explode/youtube_explode_helper.dart';

import 'core/theme/app_theme.dart';
import 'features/download_video/view/screens/main_screen.dart';
import 'features/download_video/view_model/cubit/video_downloader_bloc_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  DioHelper.init();
  YoutubeExplodeHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
