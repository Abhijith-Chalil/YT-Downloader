import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<VidDatabaseBloc>().add(GetAllVidFromDb());
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed('/home');
    });
    return const Scaffold(
      body: Center(
        child: Text(
          "YT Downloader",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
