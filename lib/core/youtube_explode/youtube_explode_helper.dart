import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeExplodeHelper {
  static late YoutubeExplode _yt;
  static void init() {
    _yt = YoutubeExplode();
  }

  static Future<Video> getVideo(String url) async {
    return await _yt.videos.get(url);
  }

  static Future<StreamManifest> getStreamManifest(String url) async {
    return await _yt.videos.streamsClient.getManifest(url);
  }
}
