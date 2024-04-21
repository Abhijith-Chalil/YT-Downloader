import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yt_downloader/core/database/db_vid.dart';
import 'package:yt_downloader/core/enums/enums.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

part 'vid_database_event.dart';
part 'vid_database_state.dart';

class VidDatabaseBloc extends Bloc<VidDatabaseEvent, VidDatabaseState> {
  VidDatabaseBloc() : super(VidDatabaseInitial()) {
    /// Handles the retrieval of all videos from the database.
    /// When the [GetAllVidFromDb] event is received, this handler will:
    /// 1. Emit a [VidDatabaseState] with an [ApiStatus.loading] status to indicate that the data is being loaded.
    /// 2. Attempt to retrieve all videos from the [VideoDb] service.
    /// 3. If the retrieval is successful, emit a [VidDatabaseState] with an [ApiStatus.completed] status and the retrieved videos.
    /// 4. If an error occurs during the retrieval, emit a [VidDatabaseState] with an [ApiStatus.error] status and an empty list of videos.
    on<GetAllVidFromDb>((event, emit) async {
      emit(const VidDatabaseState(videos: [], apiStatus: ApiStatus.loading));
      try {
        final vids = await VideoDb.getAllVideos();
        emit(VidDatabaseState(videos: vids, apiStatus: ApiStatus.completed));
      } catch (e) {
        emit(const VidDatabaseState(videos: [], apiStatus: ApiStatus.error));
      }
    });

    /// Deletes a video from the database and updates the state to reflect the removal.
    /// This event handler is used to delete a specific video from the database. It first
    /// calls the `deleteVideo` method on the `VideoDb` class to remove the video from
    /// the database. It then updates the `videos` list in the state by removing the
    /// video with the same ID as the one that was deleted.
    /// @param event The [DeleteVideoFromDb] event that contains the ID of the video to delete.
    /// Emit the `GetAllVidFromDb` event to refresh the list of videos in the database.
    on<DeleteVideoFromDb>((event, emit) async {
      await VideoDb.deleteVideo(event.id);
      final videos = state.videos;
      videos.removeWhere((element) => element.id == event.id);
      emit(VidDatabaseState(
        videos: videos,
      ));
    });

    /// Handles the deletion of all videos in the video database.
    /// When the `DeleteAllVideos` event is received, this method will:
    /// 1. Delete all videos from the video database using the `VideoDb.deleteAllVideos()` method.
    /// 2. Emit the `GetAllVidFromDb` event to refresh the list of videos in the database.
    on<DeleteAllVideos>((event, emit) async {
      await VideoDb.deleteAllVideos();
      add(GetAllVidFromDb());
    });
  }
}
