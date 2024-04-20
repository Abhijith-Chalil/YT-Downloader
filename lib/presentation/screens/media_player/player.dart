import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';
import 'package:yt_downloader/presentation/theme/colors/bg_colors.dart';
import 'package:yt_downloader/presentation/theme/colors/text_colors.dart';
import 'package:yt_downloader/presentation/theme/styles/font_style.dart';

class Player extends StatelessWidget {
  final YtVidMetaData vidMetaData;
  const Player({super.key, required this.vidMetaData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BgColor.scaffold,
      appBar: AppBar(
        backgroundColor: BgColor.appBar,
        foregroundColor: TextColor.appBar,
        title: Text(
          vidMetaData.title ?? "",
          style: FontStyle.defaultText.copyWith(fontSize: 15),
          maxLines: 3,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: BetterPlayer(
        controller: BetterPlayerController(
          const BetterPlayerConfiguration(
            autoDetectFullscreenAspectRatio: true,
            autoPlay: true,
            autoDispose: true,
            fullScreenByDefault: true,
          ),
          betterPlayerDataSource: BetterPlayerDataSource(
            BetterPlayerDataSourceType.file,
            vidMetaData.videoPath!,
          ),
        ),
      )),
    );
  }
}
