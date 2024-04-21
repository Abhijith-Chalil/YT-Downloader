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

  /// Downloads a YouTube video and saves it to the device's file system.
  /// This method retrieves the video stream with the highest bitrate, downloads the
  /// video data, and saves it to a file in the application's documents directory.
  /// The progress of the download is reported via the `updateProgress` callback.
  /// Parameters:
  /// - `ytVideoLink`: The URL of the YouTube video to download.
  /// - `fileName`: The name of the file to save the downloaded video to.
  /// - `updateProgress`: A callback function that is called periodically to report
  ///   the progress of the download. The callback is passed an integer value
  ///   representing the current download progress as a percentage.
  /// Returns:
  /// The file path of the downloaded video.
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
      final file = File(
          "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4");
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

  /// Retrieves the metadata for a YouTube video given the video link.
  /// This method attempts to fetch the video metadata from the YouTube API, including the
  /// video title, description, thumbnail URL, and duration. If the API call is successful,
  /// the metadata is returned as a [YtVidMetaData] object. If the API call fails, `null` is
  /// returned.
  /// Parameters:
  /// - `ytVideoLink`: The URL of the YouTube video to retrieve metadata for.
  /// Returns:
  /// A [YtVidMetaData] object containing the video metadata, or `null` if the API call fails.
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
      rethrow;
    }
  }

  /// Downloads an image from the provided URL and saves it to the application documents directory.
  /// Parameters:
  /// - `url`: The URL of the image to download.
  /// Returns:
  /// The file path of the downloaded image.
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

  /// Cancels the ongoing file download by closing the file stream and setting it to null.
  /// This method is used to stop an active file download process. It closes the underlying file stream
  /// and sets the `stream` property to `null`, effectively canceling the download operation.
  @override
  Future<void> cancelDownloading() async {
    await fileStream?.close();
    stream = null;
  }
}
