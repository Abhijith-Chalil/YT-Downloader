import 'package:go_router/go_router.dart';
import 'package:yt_downloader/presentation/screens/home/home_screen.dart';
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
    builder: (context, state) => HomeScreen(),
  )
]);
