import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/core/constants/home_screen_const.dart';
import 'package:yt_downloader/presentation/theme/colors/bg_colors.dart';
import 'package:yt_downloader/presentation/theme/colors/text_colors.dart';
import 'package:yt_downloader/presentation/theme/styles/font_style.dart';
import 'package:yt_downloader/presentation/widgets/animated_widgets/list_item.dart';
import 'package:yt_downloader/presentation/widgets/spacer.dart';

class VideoList extends StatelessWidget {
  const VideoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BgColor.scaffold,
      appBar: AppBar(
        backgroundColor: BgColor.appBar,
        foregroundColor: TextColor.appBar,
        title: const Text(kDownloadedVideos,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: SizedBox(
        child: BlocBuilder<VidDatabaseBloc, VidDatabaseState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final metaData = state.videos[index];
                    return AnimatedListItem(
                      onTap: () {
                        // Navigate to player screen
                        context.push("/player", extra: metaData);
                      },
                      index,
                      key: ValueKey<int>(index),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(metaData.thumbnail!)),
                                    fit: BoxFit.cover),
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    metaData.title ?? "",
                                    style: FontStyle.defaultText.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  kH4,
                                  Text(
                                    metaData.description ??
                                        "No description available",
                                    style: FontStyle.defaultText,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  kH4,
                                  Text(
                                    "Duration: ${metaData.duration}",
                                    style: FontStyle.defaultText,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.videos.length),
            );
          },
        ),
      ),
    );
  }
}
