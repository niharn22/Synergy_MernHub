// import 'package:construct_hub/controllers/storage_controller.dart';
import 'package:construct_hub/core/utils/app_styles.dart';
import 'package:construct_hub/models/file_model.dart';
import 'package:construct_hub/widgets/display_files_screen/download_remove_bottom_sheet.dart';
// import 'package:construct_hub/widgets/storage_screen/storage_container.dart';
import 'package:construct_hub/widgets/view_file_screen/play_audio_widget.dart';
import 'package:construct_hub/widgets/view_file_screen/show_file_widget.dart';
import 'package:construct_hub/widgets/view_file_screen/show_image_widget.dart';
import 'package:construct_hub/widgets/view_file_screen/view_video_widget.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class ViewFileScreen extends StatelessWidget {
  final FileModel file;
  const ViewFileScreen({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(
          file.name,
          style: AppStyles.textStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return DownloadRemoveBottomSheet(file: file);
                  });
            },
          )
        ],
      ),
      body: file.type == "image"
          ? ShowImageWidget(
              url: file.url,
            )
          : file.type == "video"
              ? ViewVideoWidget(
                  url: file.url,
                )
              : file.type == "audio"
                  ? PlayAudioWidget(
                      url: file.url,
                      name: file.name.split(".")[0],
                    )
                  : ShowFileWidget(
                      fileModel: file,
                    ),
    );
  }
}
