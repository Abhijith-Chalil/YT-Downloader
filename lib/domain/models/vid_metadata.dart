// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'vid_metadata.g.dart';

@Collection()
class YtVidMetaData {
  Id id = Isar.autoIncrement;
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? duration;
  final String? ytVidUrl;
  late final String? videoPath;

  YtVidMetaData(
      {this.title,
      this.description,
      this.thumbnail,
      this.duration,
      this.ytVidUrl,
      this.videoPath});

  YtVidMetaData copyWith({
    String? title,
    String? description,
    String? thumbnail,
    String? duration,
    String? videoPath,
    String? ytVidUrl,
  }) {
    return YtVidMetaData(
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      duration: duration ?? this.duration,
      videoPath: videoPath ?? this.videoPath,
      ytVidUrl: ytVidUrl ?? this.ytVidUrl,
    );
  }
}
