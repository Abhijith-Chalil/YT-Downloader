import 'package:flutter/material.dart';
import 'package:yt_downloader/core/constants/alert_const.dart';
import 'package:yt_downloader/presentation/theme/styles/font_style.dart';

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
            title: const Text(kError),
            content: Text(message ?? ""),
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
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
