// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vid_database_bloc.dart';

@immutable
class VidDatabaseState {
  final ApiStatus? apiStatus;
  final List<YtVidMetaData> videos;

  const VidDatabaseState({required this.videos, this.apiStatus});

  VidDatabaseState copyWith({
    ApiStatus? apiStatus,
    List<YtVidMetaData>? videos,
  }) {
    return VidDatabaseState(
        videos: videos ?? this.videos, apiStatus: apiStatus ?? this.apiStatus);
  }
}

final class VidDatabaseInitial extends VidDatabaseState {
  VidDatabaseInitial() : super(videos: [], apiStatus: ApiStatus.initial);
}
