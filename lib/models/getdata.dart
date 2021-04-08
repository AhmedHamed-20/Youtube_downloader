import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vedio_downloader/screens/home_screen.dart';

var url = MyHomePageState();
bool error;
String videoname = '';

class Data {}

var yt = YoutubeExplode();
double statistics = 0.0;

void logCallback(int level, double message) {
  statistics = message;

  //print(statistics);
}

void getvedio(String url) async {
  try {
    var storageperm = Permission.storage;

    var permissions = await storageperm.request();
    var Dir = await DownloadsPathProvider.downloadsDirectory;
    print(Dir);
    Directory(Dir.path).createSync();
    String url2 = url.trim();
    var video = await yt.videos.get(url2);
    error = false;
    var manifest = await yt.videos.streamsClient.getManifest(url2);
    var streams = manifest.muxed;
    // final path = Directory.current;
    String fileName = video.title;
    videoname = fileName;
    var file = File('/storage/emulated/0/Download/${fileName}.mp4');

    var output = file.openWrite(mode: FileMode.writeOnlyAppend);
    var audio = streams.withHighestBitrate();
    var audioStream = yt.videos.streamsClient.get(audio);
    double len = audio.size.totalBytes.toDouble();
    double count = 0;
    double indicator = 0;
    await for (var data in audioStream) {
      // Keep track of the current downloaded data.
      count += data.length.toDouble();

      // Calculate the current progress.

      double progress = ((count / len) / 1);
      // Update the progressbar.
      logCallback(100, progress);

      // Write to file.
      output.add(data);
    }
    // double len = audio.size.totalBytes.toDouble();
    // double count = 0;
    // double indicator = 0;
    output.close();
  } catch (_) {
    print('Error');
    error = true;
  }
}

void getaudio(String url) async {
  try {
    var storageperm = Permission.storage;
    print(url);
    var permissions = await storageperm.request();
    var Dir = await DownloadsPathProvider.downloadsDirectory;
    print(Dir);
    Directory(Dir.path).createSync();
    String url2 = url.trim();
    print(url2);
    var video = await yt.videos.get(url2);
    error = false;
    String fileName = video.title;
    videoname = fileName;
    print(fileName);
    var manifest = await yt.videos.streamsClient.getManifest(url2);
    var streams = manifest.audioOnly;
    // final path = Directory.current;
    var file = File('/storage/emulated/0/Download/${fileName}.mp3');

    var output = file.openWrite(mode: FileMode.writeOnlyAppend);
    var audio = streams.withHighestBitrate();
    var audioStream = yt.videos.streamsClient.get(audio);
    double len = audio.size.totalBytes.toDouble();
    double count = 0;
    double indicator = 0;
    await for (var data in audioStream) {
      // Keep track of the current downloaded data.
      count += data.length.toDouble();

      // Calculate the current progress.

      double progress = ((count / len) / 1);
      // Update the progressbar.
      logCallback(100, progress);

      // Write to file.
      output.add(data);
    }
    // double len = audio.size.totalBytes.toDouble();
    // double count = 0;
    // double indicator = 0;
    output.close();
  } catch (_) {
    print('Error');
    error = true;
  }
}
