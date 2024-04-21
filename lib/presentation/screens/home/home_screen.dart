import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/core/constants/drawer_const.dart';
import 'package:yt_downloader/core/constants/home_screen_const.dart';
import 'package:yt_downloader/presentation/screens/home/widgets/search_history_list.dart';
import 'package:yt_downloader/presentation/screens/home/widgets/vid_search.dart';
import 'package:yt_downloader/presentation/theme/colors/app_color.dart';
import 'package:yt_downloader/presentation/theme/colors/bg_colors.dart';
import 'package:yt_downloader/presentation/theme/colors/text_colors.dart';
import 'package:yt_downloader/presentation/theme/styles/font_style.dart';
import 'package:yt_downloader/presentation/widgets/spacer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BgColor.scaffold,
      drawer: Drawer(
        backgroundColor: BgColor.drawer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            customDrawerDeleteTile(
              title: kDownloadedVideo,
              icon: Icons.download,
              onTap: () {
                context.pop();
                context.push("/videoList");
              },
            ),
            customDrawerDeleteTile(
              title: kClearDownloadHistory,
              onTap: () {
                context.pop();
                context.read<VidDatabaseBloc>().add(DeleteAllVideos());
              },
            ),
            kH50,
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: BgColor.appBar,
        foregroundColor: TextColor.appBar,
        title: const Text(kAppName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [VideoSearchTile(), kH20, const SearchHistoryList()],
          ),
        ),
      )),
    );
  }

  ListTile customDrawerDeleteTile(
      {required String title, required VoidCallback onTap, IconData? icon}) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 5,
      leading: Icon(
        icon ?? Icons.delete,
        color: AppColor.themeColor,
        size: 18,
      ),
      title: Text(
        title,
        style: FontStyle.defaultText,
      ),
    );
  }
}
