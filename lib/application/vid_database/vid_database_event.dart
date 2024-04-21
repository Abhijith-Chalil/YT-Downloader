// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vid_database_bloc.dart';

@immutable
sealed class VidDatabaseEvent {}

class GetAllVidFromDb extends VidDatabaseEvent {}

/// Deletes a video from the database by its unique identifier.
/// This event is used to request the deletion of a specific video from the
/// video database. The [id] parameter specifies the unique identifier of the
/// video to be deleted.
class DeleteVideoFromDb extends VidDatabaseEvent {
  final int id;
  DeleteVideoFromDb({
    required this.id,
  });
}

/// Represents an event to store a YouTube video metadata in the database.
/// The [ytVidMetaData] parameter contains the metadata of the YouTube video to be stored.
class StoreVidToDb extends VidDatabaseEvent {
  final YtVidMetaData ytVidMetaData;

  StoreVidToDb({required this.ytVidMetaData});
}

/// Deletes all videos from the database.
/// This event is used to request the deletion of all videos from the
/// video database.
class DeleteAllVideos extends VidDatabaseEvent {}
