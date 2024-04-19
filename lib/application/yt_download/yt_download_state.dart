// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'yt_download_bloc.dart';

@immutable
class YtDownloadState {
  final ApiStatus? ytMeataDataApiStatus;
  final YtVidMetaData? ytVidMetaData;
  final String? errorMessage;
  final int? progress;
  final ApiStatus? vidDownloadingStats;
  final bool? isNewVideo;

  const YtDownloadState(
      {this.ytMeataDataApiStatus,
      this.ytVidMetaData,
      this.vidDownloadingStats,
      this.progress,
      this.isNewVideo,
      this.errorMessage});

  YtDownloadState copyWith(
      {ApiStatus? ytMeataDataApiStatus,
      YtVidMetaData? ytVidMetaData,
      Stream<List<int>>? ytStream,
      String? errorMessage,
      ApiStatus? vidDownloadingStats,
      bool? isNewVideo,
      int? progress}) {
    return YtDownloadState(
      ytMeataDataApiStatus: ytMeataDataApiStatus ?? this.ytMeataDataApiStatus,
      ytVidMetaData: ytVidMetaData ?? this.ytVidMetaData,
      errorMessage: errorMessage ?? this.errorMessage,
      vidDownloadingStats: vidDownloadingStats ?? this.vidDownloadingStats,
      progress: progress ?? this.progress,
      isNewVideo: isNewVideo ?? this.isNewVideo,
    );
  }
}

class YtDownloadInitial extends YtDownloadState {
  YtDownloadInitial()
      : super(
            ytMeataDataApiStatus: ApiStatus.initial,
            vidDownloadingStats: ApiStatus.initial,
            progress: 0,
            isNewVideo: true,
            ytVidMetaData: YtVidMetaData(
              title: "",
              description: "",
              thumbnail: ytLogo,
              duration: "0:00",
            ));
}
