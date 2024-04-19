import 'package:flutter/material.dart';
import 'package:yt_downloader/core/constants/alert_const.dart';
import 'package:yt_downloader/presentation/theme/colors/text_colors.dart';
import 'package:yt_downloader/presentation/theme/styles/font_style.dart';
import 'package:yt_downloader/presentation/widgets/spacer.dart';

class CustomAlertBox {
  static showAlert(
      {required BuildContext context,
      String? message,
      VoidCallback? onConfirm,
      int? width}) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.bounceIn,
          child: AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  kError,
                  style: FontStyle.defaultText.copyWith(
                      color: TextColor.error, fontWeight: FontWeight.bold),
                ),
                kH8,
                Text(
                  message ?? "",
                  style: FontStyle.defaultText.copyWith(color: TextColor.alert),
                ),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  if (onConfirm != null) {
                    onConfirm();
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Ok",
                  style: FontStyle.defaultText.copyWith(
                      color: TextColor.alert, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
