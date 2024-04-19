// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vid_database_bloc.dart';

@immutable
class VidDatabaseState {
  final List<YtVidMetaData> videos;

  const VidDatabaseState({required this.videos,});

  VidDatabaseState copyWith({
    List<YtVidMetaData>? videos,
  }) {
    return VidDatabaseState(
      videos: videos ?? this.videos,
    );
  }
}

final class VidDatabaseInitial extends VidDatabaseState {
  VidDatabaseInitial() : super(videos: []);
}
