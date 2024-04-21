import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yt_downloader/core/database/db_vid.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

part 'vid_database_event.dart';
part 'vid_database_state.dart';


class VidDatabaseBloc extends Bloc<VidDatabaseEvent, VidDatabaseState> {
  VidDatabaseBloc() : super(VidDatabaseInitial()) {
    on<GetAllVidFromDb>((event, emit) async {
      final vids = await VideoDb.getAllVideos();
      emit(VidDatabaseState(videos: vids));
    });
  }
}
