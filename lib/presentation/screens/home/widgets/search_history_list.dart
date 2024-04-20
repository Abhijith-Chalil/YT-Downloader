import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/core/constants/home_screen_const.dart';
import 'package:yt_downloader/presentation/theme/colors/text_colors.dart';
import 'package:yt_downloader/presentation/theme/styles/font_style.dart';
import 'package:yt_downloader/presentation/widgets/animated_widgets/list_item.dart';
import 'package:yt_downloader/presentation/widgets/spacer.dart';

class SearchHistoryList extends StatelessWidget {
  const SearchHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<VidDatabaseBloc, VidDatabaseState>(
        builder: (context, state) {
          if (state.videos.isEmpty) {
            return Text(
              kNoHistoryFound,
              style: FontStyle.defaultText.copyWith(
                  color: TextColor.defaultText,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Search History",
                  style: FontStyle.defaultText.copyWith(
                      color: TextColor.defaultText,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                kH20,
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final metaData = state.videos[index];
                      return AnimatedListItem(
                        index,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            metaData.title ?? "No Title",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: FontStyle.defaultText,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => kH8,
                    itemCount: state.videos.length),
              ],
            );
          }
        },
      ),
    );
  }
}
