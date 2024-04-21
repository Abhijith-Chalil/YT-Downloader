// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'yt_download_bloc.dart';

@immutable
abstract class YtDownloadEvent {}

class DownloadYtVideo extends YtDownloadEvent {
  final String ytVideoLink;
  final VidDatabaseBloc vidDatabaseBloc;

  DownloadYtVideo({required this.ytVideoLink, required this.vidDatabaseBloc});
}

class CancelDownloading extends YtDownloadEvent {}
