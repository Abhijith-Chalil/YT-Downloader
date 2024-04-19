import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/core/constants/alert_const.dart';
import 'package:yt_downloader/core/constants/urls.dart';
import 'package:yt_downloader/core/di/injectable.dart';
import 'package:yt_downloader/core/enums/enums.dart';
import 'package:yt_downloader/domain/download_yt_vid/i_download_repo.dart';
import 'package:yt_downloader/domain/models/database/db_vid.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

part 'yt_download_event.dart';
part 'yt_download_state.dart';

@injectable
class YtDownloadBloc extends Bloc<YtDownloadEvent, YtDownloadState> {
  final IDownloadYtVidRepo _downloadRepo;
  final VidDatabaseBloc _vidDatabaseBloc;
  YtDownloadBloc(this._downloadRepo, this._vidDatabaseBloc)
      : super(YtDownloadInitial()) {
    on<DownloadYtVideo>((event, emit) async {
      bool isNewVideo = true;
      final vidFromDb = _vidDatabaseBloc.state.videos;
      for (var element in vidFromDb) {
        if (element.ytVidUrl == event.ytVideoLink) {
          isNewVideo = false;
        }
      }
      if (isNewVideo) {
        try {
          emit(state.copyWith(ytMeataDataApiStatus: ApiStatus.loading));
          final metaData = await _downloadRepo.getYtMetaData(
            ytVideoLink: event.ytVideoLink,
          );
          emit(state.copyWith(
              ytMeataDataApiStatus: ApiStatus.completed,
              vidDownloadingStats: ApiStatus.loading,
              ytVidMetaData: metaData));
          final vidPath = await _downloadRepo.downloadYtVideo(
              updateProgress: (int progress) {
                emit(state.copyWith(
                  progress: progress,
                ));
              },
              ytVideoLink: event.ytVideoLink,
              fileName: metaData!.title ?? "ytVid");
          final updaetdMetaData = metaData.copyWith(videoPath: vidPath);
          await VideoDb.storeVideo(updaetdMetaData);
          emit(state.copyWith(
              vidDownloadingStats: ApiStatus.completed,
              ytVidMetaData: updaetdMetaData));
        } on SocketException {
          emit(state.copyWith(
              ytMeataDataApiStatus: ApiStatus.error,
              errorMessage: kNoInternet));
        } catch (e) {
          emit(state.copyWith(
              ytMeataDataApiStatus: ApiStatus.error,
              vidDownloadingStats: ApiStatus.error,
              errorMessage: e.toString().split(":")[1]));
        }
      }
    });
  }
}
