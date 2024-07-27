// import 'dart:developer';
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:construct_hub/controllers/download_controller.dart';
// import 'package:construct_hub/core/firebase_services/firebase_services.dart';
import 'package:construct_hub/models/file_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadRemoveBottomSheet extends StatefulWidget {
  final FileModel file;
  const DownloadRemoveBottomSheet({super.key, required this.file});

  @override
  State<DownloadRemoveBottomSheet> createState() =>
      _DownloadRemoveBottomSheetState();
}

class _DownloadRemoveBottomSheetState extends State<DownloadRemoveBottomSheet> {
  bool fileDownloaded = false;
  late File file;

  @override
  void initState() {
    super.initState();
    file = File(
        '/storage/emulated/0/Download/${widget.file.name.replaceAll(" ", "")}');
    isFileExist();
  }

  Future<void> isFileExist() async {
    fileDownloaded = await file.exists();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DownloadDeleteController());
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.file.name.split(".")[0]),
          const SizedBox(
            height: 24,
          ),
          fileDownloaded == true
              ? const Row(
                  children: [
                    Icon(
                      EvaIcons.checkmark,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Already downloaded",
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
                )
              : InkWell(
                  onTap: () async {
                    await controller.downloadFile(widget.file);
                    Navigator.of(context).pop();
                  },
                  child: GetBuilder<DownloadDeleteController>(builder: (_) {
                    return Row(
                      children: [
                        controller.isDownloading
                            ? const SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.deepOrange,
                                ),
                              )
                            : const Icon(EvaIcons.download),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          controller.isDownloading ? "Downloading" : "Download",
                          style: TextStyle(
                              fontSize: 16,
                              color: controller.isDownloading == true
                                  ? Colors.deepOrange
                                  : Colors.black),
                        ),
                      ],
                    );
                  }),
                ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () async {
              await controller.deleteFile(widget.file);
              Navigator.of(context).pop();
            },
            child: const Row(
              children: [
                Icon(EvaIcons.fileRemove),
                SizedBox(
                  width: 6,
                ),
                Text("Remove"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
