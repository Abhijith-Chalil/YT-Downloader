import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yt_downloader/core/database/db_vid.dart';
import 'package:yt_downloader/core/enums/enums.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

part 'vid_database_event.dart';
part 'vid_database_state.dart';

class VidDatabaseBloc extends Bloc<VidDatabaseEvent, VidDatabaseState> {
  VidDatabaseBloc() : super(VidDatabaseInitial()) {
    on<GetAllVidFromDb>((event, emit) async {
      emit(const VidDatabaseState(videos: [], apiStatus: ApiStatus.loading));
      try {
        final vids = await VideoDb.getAllVideos();
        emit(VidDatabaseState(videos: vids, apiStatus: ApiStatus.completed));
      } catch (e) {
        emit(const VidDatabaseState(videos: [], apiStatus: ApiStatus.error));
      }
    });

    on<DeleteVideoFromDb>((event, emit) async {
      await VideoDb.deleteVideo(event.id);
      final videos = state.videos;
      videos.removeWhere((element) => element.id == event.id);
      emit(VidDatabaseState(
        videos: videos,
      ));
    });
  }
}
