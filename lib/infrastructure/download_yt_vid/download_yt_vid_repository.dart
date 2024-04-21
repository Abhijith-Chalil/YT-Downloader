import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:yt_downloader/core/helpers/helpers.dart';
import 'package:yt_downloader/domain/download_yt_vid/i_download_repo.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

@LazySingleton(as: IDownloadYtVidRepo)
class DownloadYtVidRepository implements IDownloadYtVidRepo {
  final yt = YoutubeExplode();
  IOSink? fileStream;
  Stream<List<int>>? stream;
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
      stream = yt.videos.streamsClient.get(streamInfo);
      final directory = await getApplicationDocumentsDirectory();
      final file = File("${directory.path}/${ytVideoLink.split("=").last}.mp4");
      if (file.existsSync()) {
        file.deleteSync();
      }

      fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);

      await for (final data in stream!) {
        // Keep track of the current downloaded data.
        count += data.length;
        // Calculate the current progress.
        final int progress = ((count / len) * 100).ceil();
        updateProgress(progress);
        // Write to file.
        fileStream?.add(data);
      }

      await fileStream?.flush();
      await fileStream?.close();
      stream = null;
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
          thumbnailUrl: video.thumbnails.mediumResUrl,
          ytVidUrl: ytVideoLink,
          duration: Helpers.formatDuration(video.duration!));
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<String> downloadAndSaveImage({required String url}) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
    try {
      await Dio().download(url, filePath);
      return filePath;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancelDownloading() async {
    await fileStream?.close();
    stream = null;
  }
}
