import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class BaseVideoInformationModel extends Equatable {
  final String title;
  final String description;
  final String videoThumbnail;
  final String url;

  const BaseVideoInformationModel(
      {required this.title,
      required this.description,
      required this.url,
      required this.videoThumbnail});

  factory BaseVideoInformationModel.fromVideo(Video video) {
    return BaseVideoInformationModel(
      title: video.title,
      videoThumbnail: video.thumbnails.mediumResUrl,
      description: video.description,
      url: video.url,
    );
  }

  @override
  List<Object?> get props => [title, description, url];
}
