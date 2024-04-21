// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vid_database_bloc.dart';

@immutable
sealed class VidDatabaseEvent {}

class GetAllVidFromDb extends VidDatabaseEvent {}

class DeleteVideoFromDb extends VidDatabaseEvent {
  final int id;
  DeleteVideoFromDb({
    required this.id,
  });
}

class StoreVidToDb extends VidDatabaseEvent {
  final YtVidMetaData ytVidMetaData;

  StoreVidToDb({required this.ytVidMetaData});
}

class DeleteAllVideos extends VidDatabaseEvent {}
