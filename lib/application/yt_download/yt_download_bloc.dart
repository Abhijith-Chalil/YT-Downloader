import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/core/constants/alert_const.dart';
import 'package:yt_downloader/core/constants/urls.dart';
import 'package:yt_downloader/core/di/injectable.dart';
import 'package:yt_downloader/core/enums/enums.dart';
import 'package:yt_downloader/core/helpers/helpers.dart';
import 'package:yt_downloader/domain/download_yt_vid/i_download_repo.dart';
import 'package:yt_downloader/core/database/db_vid.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

part 'yt_download_event.dart';
part 'yt_download_state.dart';

class YtDownloadBloc extends Bloc<YtDownloadEvent, YtDownloadState> {
  YtDownloadBloc() : super(YtDownloadInitial()) {
    final IDownloadYtVidRepo downloadRepo = getIt<IDownloadYtVidRepo>();
    on<DownloadYtVideo>((event, emit) async {
      final vidFromDb = event.vidDatabaseBloc.state.videos;
      for (var element in vidFromDb) {
        if (element.ytVidUrl == event.ytVideoLink) {
          emit(state.copyWith(isNewVideo: false));
        }
      }
      bool permissionGranted =
          await Helpers.requestPermission(Permission.storage);
      if (state.isNewVideo! && permissionGranted) {
        try {
          emit(state.copyWith(
            ytMeataDataApiStatus: ApiStatus.loading,
            vidDownloadingStats: ApiStatus.loading,
          ));
          final metaData = await downloadRepo.getYtMetaData(
            ytVideoLink: event.ytVideoLink,
          );
          emit(state.copyWith(
              ytMeataDataApiStatus: ApiStatus.completed,
              ytVidMetaData: metaData));
          final vidPath = await downloadRepo.downloadYtVideo(
              updateProgress: (int progress) {
                emit(state.copyWith(
                  progress: progress,
                ));
              },
              ytVideoLink: event.ytVideoLink,
              fileName: metaData!.title ?? "ytVid");
          final updaetdMetaData = metaData.copyWith(
            videoPath: vidPath,
            thumbnail: await downloadRepo.downloadAndSaveImage(
                url: metaData.thumbnailUrl!),
          );
          await VideoDb.storeVideo(updaetdMetaData);
          emit(state.copyWith(
              vidDownloadingStats: ApiStatus.completed,
              ytVidMetaData: updaetdMetaData,
              isNewVideo: true));
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

    on<CancelDownloading>((event, emit) {
      downloadRepo.cancelDownloading();
      emit(state.copyWith(vidDownloadingStats: ApiStatus.initial, progress: 0));
    });
  }
}
