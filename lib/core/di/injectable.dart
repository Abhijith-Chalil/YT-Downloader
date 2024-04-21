import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/application/yt_download/yt_download_bloc.dart';
import 'package:yt_downloader/core/di/injectable.config.dart';

final getIt = GetIt.instance;

/// Configures the dependency injection for the application.
/// This function sets up the GetIt instance with the necessary dependencies,
/// including the [VidDatabaseBloc] and [YtDownloadBloc] factories.
@InjectableInit()
Future<void> configureInjection() async {
  getIt.init(environment: Environment.prod);
  getIt.registerFactory(() => VidDatabaseBloc());
  getIt.registerFactory(() => YtDownloadBloc());
}
