import 'package:go_router/go_router.dart';
import 'package:yt_downloader/domain/models/vid_metadata.dart';
import 'package:yt_downloader/presentation/screens/home/home_screen.dart';
import 'package:yt_downloader/presentation/screens/media_player/player.dart';
import 'package:yt_downloader/presentation/screens/media_player/vid_list.dart';
import 'package:yt_downloader/presentation/screens/splash_screen.dart';

/// The main GoRouter instance for the application.
/// This router defines the following routes:
final GoRouter router = GoRouter(initialLocation: '/', routes: [
  /// - `/`: The initial splash screen.
  GoRoute(
    name: "/",
    path: "/",
    builder: (context, state) => const SplashScreen(),
  ),

  /// - `/home`: The main home screen.
  GoRoute(
    name: "/home",
    path: "/home",
    builder: (context, state) => const HomeScreen(),
  ),

  /// - `/videoList`: The screen that displays a list of videos.
  GoRoute(
    name: "/videoList",
    path: "/videoList",
    builder: (context, state) => const VideoList(),
  ),

  /// - `/player`: The screen that plays a video, taking a [YtVidMetaData] object as an argument.
  GoRoute(
    name: "/player",
    path: "/player",
    builder: (context, state) =>
        Player(vidMetaData: state.extra as YtVidMetaData),
  )
]);
