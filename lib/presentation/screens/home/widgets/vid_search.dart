import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_downloader/application/vid_database/vid_database_bloc.dart';
import 'package:yt_downloader/application/yt_download/yt_download_bloc.dart';
import 'package:yt_downloader/core/constants/home_screen_const.dart';
import 'package:yt_downloader/core/enums/enums.dart';
import 'package:yt_downloader/presentation/theme/colors/app_color.dart';
import 'package:yt_downloader/presentation/theme/colors/bg_colors.dart';
import 'package:yt_downloader/presentation/theme/colors/text_colors.dart';
import 'package:yt_downloader/presentation/theme/styles/font_style.dart';
import 'package:yt_downloader/presentation/widgets/alert/custome_alert_box.dart';
import 'package:yt_downloader/presentation/widgets/spacer.dart';

class VideoSearchTile extends StatelessWidget {
  VideoSearchTile({super.key});
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<YtDownloadBloc, YtDownloadState>(
      listener: (context, state) {
        if (state.ytMeataDataApiStatus == ApiStatus.error) {
          CustomAlertBox.showAlert(
            context: context,
            message: state.errorMessage,
          );
        } else if (state.vidDownloadingStats == ApiStatus.completed) {
          context.read<VidDatabaseBloc>().add(GetAllVidFromDb());
        }
        if (!state.isNewVideo!) {
          CustomAlertBox.showAlert(
              context: context, message: "This Video Already Eixsts");
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: urlInputField()),
                kW4,
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<YtDownloadBloc>().add(DownloadYtVideo(
                          vidDatabaseBloc: context.read<VidDatabaseBloc>(),
                          ytVideoLink: _controller.text.trim()));
                    }
                  },
                  child: const CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColor.themeColor,
                    child: Icon(
                      Icons.download,
                      color: BgColor.iconColor,
                    ),
                  ),
                )
              ],
            ),
            kH20,
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.bounceInOut,
              alignment: Alignment.bottomLeft,
              height:
                  state.ytMeataDataApiStatus == ApiStatus.completed ? 200 : 0,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(10.0),
                  image: state.ytMeataDataApiStatus == ApiStatus.completed
                      ? DecorationImage(
                          image: NetworkImage(
                              state.ytVidMetaData!.thumbnailUrl ?? ""),
                          fit: BoxFit.cover)
                      : null),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 1, // Spread radius
                        blurRadius: 6, // Blur radius
                        offset: const Offset(
                            2, 6), // Offset in the x and y direction
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.ytVidMetaData!.title ?? "",
                        style: FontStyle.defaultText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: state.progress!.toDouble() / 100,
                              minHeight: 5,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ),
                          kW4,
                          SizedBox(
                            width: 38,
                            child: Text(
                              "${state.progress}%",
                              textAlign: TextAlign.end,
                              style: FontStyle.defaultText,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Container urlInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          style: FontStyle.defaultText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the url';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: kEnterYourVideoLink,
            hintStyle:
                FontStyle.defaultText.copyWith(color: TextColor.hintText),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
