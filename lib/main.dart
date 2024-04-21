import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/application/yt_download/yt_download_bloc.dart';
import 'package:yt_downloader/core/constants/home_screen_const.dart';
import 'package:yt_downloader/core/di/injectable.dart';
import 'package:yt_downloader/core/database/db_vid.dart';
import 'package:yt_downloader/presentation/routes/routes.dart';

Future<void> main() async {
  /// Ensures the WidgetsFlutterBinding is initialized before running the app.
  /// This is necessary to use Flutter widgets and APIs.
  WidgetsFlutterBinding.ensureInitialized();

  /// Configures the dependency injection for the application.
  await configureInjection();

  /// Initializes the video database.
  /// This method should be called before any other operations on the video database.
  /// It ensures the database is properly set up and ready for use.
  await VideoDb.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<YtDownloadBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<VidDatabaseBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: kAppName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
              bodyLarge: TextStyle(fontFamily: 'Montserrat'),
              labelLarge: TextStyle(fontFamily: 'Montserrat'),
              titleLarge: TextStyle(fontFamily: 'Montserrat')),
        ),
        routerConfig: router,
      ),
    );
  }
}
