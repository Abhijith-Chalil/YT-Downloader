import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';

class VideoDb {
  static late Isar isar;
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([YtVidMetaDataSchema], directory: dir.path);
  }

  static Future<void> storeVideo(YtVidMetaData ytVidMetaData) async {
    final x = await isar.writeTxn(() => isar.ytVidMetaDatas.put(ytVidMetaData));
    log(x.toString());
  }

  static Future<List<YtVidMetaData>> getAllVideos() async {
    final ytVidMetaDatas = await isar.ytVidMetaDatas.where().findAll();
    return ytVidMetaDatas;
  }

  static Future<bool> deleteVideo(int id) async {
    return await isar.writeTxn(() => isar.ytVidMetaDatas.delete(id));
  }

  static Future<void> deleteAllVideos() async {
    return await isar.writeTxn(() => isar.ytVidMetaDatas.clear());
  }
}
