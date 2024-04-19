// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart'
    as _i3;
import 'package:yt_downloader/application/yt_download/yt_download_bloc.dart'
    as _i6;
import 'package:yt_downloader/domain/download_yt_vid/i_download_repo.dart'
    as _i4;
import 'package:yt_downloader/infrastructure/download_yt_vid/download_yt_vid_repository.dart'
    as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.VidDatabaseBloc>(() => _i3.VidDatabaseBloc());
    gh.lazySingleton<_i4.IDownloadYtVidRepo>(
        () => _i5.DownloadYtVidRepository());
    gh.factory<_i6.YtDownloadBloc>(() => _i6.YtDownloadBloc(
          gh<_i4.IDownloadYtVidRepo>(),
          gh<_i3.VidDatabaseBloc>(),
        ));
    return this;
  }
}
