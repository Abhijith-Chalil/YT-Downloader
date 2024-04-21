// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'yt_download_bloc.dart';

@immutable
abstract class YtDownloadEvent {}

/// Represents an event to download a YouTube video.
/// This event is used to initiate the download of a YouTube video with the
/// specified [ytVideoLink]. The [vidDatabaseBloc] is provided to interact with
/// the video database during the download process.
class DownloadYtVideo extends YtDownloadEvent {
  final String ytVideoLink;
  final VidDatabaseBloc vidDatabaseBloc;

  DownloadYtVideo({required this.ytVideoLink, required this.vidDatabaseBloc});
}

/// Represents an event to cancel an ongoing YouTube video download.
/// This event is used to cancel the download of a YouTube video that is
/// currently in progress.
class CancelDownloading extends YtDownloadEvent {}
