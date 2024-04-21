import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/core/constants/home_screen_const.dart';
import 'package:yt_downloader/presentation/theme/colors/bg_colors.dart';
import 'package:yt_downloader/presentation/theme/styles/font_style.dart';
import 'package:yt_downloader/presentation/widgets/spacer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<VidDatabaseBloc>().add(GetAllVidFromDb());
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed('/home');
    });
    return Scaffold(
      backgroundColor: BgColor.scaffold,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/splash.json'),
            kH20,
            Text(
              kAppName,
              style: FontStyle.defaultText
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
