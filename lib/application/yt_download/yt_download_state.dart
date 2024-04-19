// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'yt_download_bloc.dart';

@immutable
class YtDownloadState {
  final ApiStatus? ytMeataDataApiStatus;
  final YtVidMetaData? ytVidMetaData;
  final String? errorMessage;
  final Stream<List<int>>? ytStream;
  final int? progress;
  final ApiStatus? vidDownloadingStats;

  const YtDownloadState(
      {this.ytMeataDataApiStatus,
      this.ytVidMetaData,
      this.vidDownloadingStats,
      this.ytStream,
      this.progress,
      this.errorMessage});

  YtDownloadState copyWith(
      {ApiStatus? ytMeataDataApiStatus,
      YtVidMetaData? ytVidMetaData,
      Stream<List<int>>? ytStream,
      String? errorMessage,
      ApiStatus? vidDownloadingStats,
      int? progress}) {
    return YtDownloadState(
      ytMeataDataApiStatus: ytMeataDataApiStatus ?? this.ytMeataDataApiStatus,
      ytVidMetaData: ytVidMetaData ?? this.ytVidMetaData,
      ytStream: ytStream ?? this.ytStream,
      errorMessage: errorMessage ?? this.errorMessage,
      vidDownloadingStats: vidDownloadingStats ?? this.vidDownloadingStats,
      progress: progress ?? this.progress,
    );
  }
}

class YtDownloadInitial extends YtDownloadState {
  YtDownloadInitial()
      : super(
            ytMeataDataApiStatus: ApiStatus.initial,
            vidDownloadingStats: ApiStatus.initial,
            progress: 0,
            ytVidMetaData: YtVidMetaData(
              title: "",
              description: "",
              thumbnail: ytLogo,
              duration: "0:00",
            ));
}
