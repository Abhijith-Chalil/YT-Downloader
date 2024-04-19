import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/application/yt_download/yt_download_bloc.dart';
import 'package:yt_downloader/core/di/injectable.dart';
import 'package:yt_downloader/domain/models/database/db_vid.dart';
import 'package:yt_downloader/presentation/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
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
        title: 'YT Downloader',
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
