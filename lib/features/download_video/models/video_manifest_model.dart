// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoMainfestModel extends Equatable {
  final StreamManifest streamManifest;
  final List<AudioOnlyStreamInfo> audioOnly;
  final List<MuxedStreamInfo> muxed;
  const VideoMainfestModel({
    required this.streamManifest,
    required this.audioOnly,
    required this.muxed,
  });

  factory VideoMainfestModel.fromStreamManifest(StreamManifest streamManifest) {
    return VideoMainfestModel(
        streamManifest: streamManifest,
        audioOnly: streamManifest.audioOnly,
        muxed: streamManifest.muxed);
  }

  @override
  List<Object?> get props => [streamManifest, audioOnly, muxed];
}
