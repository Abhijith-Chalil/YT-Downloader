import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/core/constants/alert_const.dart';
import 'package:yt_downloader/core/constants/urls.dart';
import 'package:yt_downloader/core/di/injectable.dart';
import 'package:yt_downloader/core/enums/enums.dart';
import 'package:yt_downloader/domain/download_yt_vid/i_download_repo.dart';
import 'package:yt_downloader/core/database/db_vid.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

part 'yt_download_event.dart';
part 'yt_download_state.dart';

class YtDownloadBloc extends Bloc<YtDownloadEvent, YtDownloadState> {
  YtDownloadBloc() : super(YtDownloadInitial()) {
    final IDownloadYtVidRepo downloadRepo = getIt<IDownloadYtVidRepo>();

    /// Handles the event to download a YouTube video.
    on<DownloadYtVideo>((event, emit) async {
      final vidFromDb = event.vidDatabaseBloc.state.videos;

      /// - Checks if the video is already downloaded and stored in the database.
      for (var element in vidFromDb) {
        if (element.ytVidUrl == event.ytVideoLink) {
          emit(state.copyWith(isNewVideo: false));
        }
      }

      /// - Requests storage permission if the video is new.
      if (state.isNewVideo!) {
        try {
          emit(state.copyWith(
              ytMeataDataApiStatus: ApiStatus.loading,
              vidDownloadingStats: ApiStatus.loading,
              progress: 0));

          /// - Fetches the video metadata from YouTube.
          final metaData = await downloadRepo.getYtMetaData(
            ytVideoLink: event.ytVideoLink,
          );
          emit(state.copyWith(
              ytMeataDataApiStatus: ApiStatus.completed,
              ytVidMetaData: metaData));

          /// - Downloads the video and saves it to the file system.
          final vidPath = await downloadRepo.downloadYtVideo(
              updateProgress: (int progress) {
                emit(state.copyWith(
                  progress: progress,
                ));
              },
              ytVideoLink: event.ytVideoLink,
              fileName: metaData!.title ?? "ytVid");

          /// - Stores the updated video metadata in the database.
          final updaetdMetaData = metaData.copyWith(
            videoPath: vidPath,
            thumbnail: await downloadRepo.downloadAndSaveImage(
                url: metaData.thumbnailUrl!),
          );
          await VideoDb.storeVideo(updaetdMetaData);

          /// - Emits the appropriate state changes during the download process.
          await Future.delayed(const Duration(seconds: 1));
          emit(state.copyWith(
              vidDownloadingStats: ApiStatus.completed,
              ytVidMetaData: updaetdMetaData,
              ytMeataDataApiStatus: ApiStatus.initial,
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
