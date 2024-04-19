import 'package:go_router/go_router.dart';
import 'package:yt_downloader/presentation/screens/home/home_screen.dart';
import 'package:yt_downloader/presentation/screens/media_player/vid_list.dart';
import 'package:yt_downloader/presentation/screens/splash_screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    name: "/",
    path: "/",
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    name: "/home",
    path: "/home",
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    name: "/videoList",
    path: "/videoList",
    builder: (context, state) => const VideoList(),
  )
]);