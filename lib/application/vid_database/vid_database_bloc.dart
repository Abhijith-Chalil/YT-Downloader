import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:yt_downloader/domain/models/database/db_vid.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

part 'vid_database_event.dart';
part 'vid_database_state.dart';

@injectable
class VidDatabaseBloc extends Bloc<VidDatabaseEvent, VidDatabaseState> {
  VidDatabaseBloc() : super(VidDatabaseInitial()) {
    on<GetAllVidFromDb>((event, emit) async {
      final vids = await VideoDb.getAllVideos();
      emit(VidDatabaseState(videos: vids));
    });
    // on<StoreVidToDb>((event, emit) async {
    //   List<YtVidMetaData> vidList = await VideoDb.getAllVideos();
    //   for (var element in vidList) {
    //     if (element.videoPath != event.ytVidMetaData.videoPath) {
    //       await VideoDb.storeVideo(event.ytVidMetaData);
    //     }
    //     vidList.add(element);
    //   }
    //   emit(VidDatabaseState(videos: vidList));
    // });
  }
}
