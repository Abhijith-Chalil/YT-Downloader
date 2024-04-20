import 'dart:developer';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:yt_downloader/core/helpers/helpers.dart';
import 'package:yt_downloader/domain/download_yt_vid/i_download_repo.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

@LazySingleton(as: IDownloadYtVidRepo)
class DownloadYtVidRepository implements IDownloadYtVidRepo {
  final yt = YoutubeExplode();
  @override
  Future<String> downloadYtVideo(
      {required String ytVideoLink,
      required String fileName,
      required Function updateProgress}) async {
    try {
      int count = 0;
      final manifest = await yt.videos.streamsClient.getManifest(ytVideoLink);
      final streamInfo = manifest.muxed.withHighestBitrate();
      final len = streamInfo.size.totalBytes;
      // Get the actual stream
      final stream = yt.videos.streamsClient.get(streamInfo);
      final directory = await getApplicationDocumentsDirectory();
      final file = File("${directory.path}/${ytVideoLink.split("=").last}.mp4");
      if (file.existsSync()) {
        file.deleteSync();
      }
      final fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);

      await for (final data in stream) {
        // Keep track of the current downloaded data.
        count += data.length;
        // Calculate the current progress.
        final int progress = ((count / len) * 100).ceil();
        updateProgress(progress);
        // Write to file.
        fileStream.add(data);
      }

      await fileStream.flush();
      await fileStream.close();
      return file.path;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<YtVidMetaData?> getYtMetaData({required String ytVideoLink}) async {
    try {
      final video = await yt.videos.get(ytVideoLink);
      final title = video.title
          .replaceAll(r'\', '')
          .replaceAll('/', '')
          .replaceAll('*', '')
          .replaceAll('?', '')
          .replaceAll('"', '')
          .replaceAll('<', '')
          .replaceAll('>', '')
          .replaceAll('|', '');
      return YtVidMetaData(
          title: title,
          description: video.description,
          thumbnail: video.thumbnails.mediumResUrl,
          ytVidUrl: ytVideoLink,
          duration: Helpers.formatDuration(video.duration!));
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
