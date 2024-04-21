import 'package:yt_downloader/domain/models/vid_metadata.dart';

abstract class IDownloadYtVidRepo {
  Future<String> downloadYtVideo(
      {required String ytVideoLink, required String fileName, required Function updateProgress});
  Future<YtVidMetaData?> getYtMetaData({required String ytVideoLink});
  Future<String> downloadAndSaveImage({required String url});
}
