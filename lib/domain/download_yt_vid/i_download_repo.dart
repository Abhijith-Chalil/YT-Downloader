import 'package:yt_downloader/domain/models/vid_metadata.dart';

/// Defines the interface for a repository that handles the downloading of YouTube videos.
/// This interface provides methods for downloading a YouTube video, retrieving the metadata of a YouTube video,
/// downloading and saving an image, and canceling an ongoing download.
abstract class IDownloadYtVidRepo {
  Future<String> downloadYtVideo(
      {required String ytVideoLink,
      required String fileName,
      required Function updateProgress});
  Future<YtVidMetaData?> getYtMetaData({required String ytVideoLink});
  Future<String> downloadAndSaveImage({required String url});
  void cancelDownloading();
}
