import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:construct_hub/controllers/upload_folder_controller.dart';
import 'package:construct_hub/core/firebase_services/firebase_services.dart';
import 'package:construct_hub/core/singeltons/connectivity_singelton.dart';
import 'package:construct_hub/core/utils/app_colors.dart';
import 'package:construct_hub/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFolderDialog extends StatefulWidget {
  const AddFolderDialog({super.key});

  @override
  State<AddFolderDialog> createState() => _AddFolderDialogState();
}

class _AddFolderDialogState extends State<AddFolderDialog> {
  late TextEditingController folderNameController;
  @override
  void initState() {
    super.initState();
    folderNameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    folderNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            // Get.back();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.textColor),
          onPressed: () async {
            if (folderNameController.text.trim().isNotEmpty) {
              final connectionResult =
                  await ConnectivitySingelton.checkInternet();
              if (connectionResult == ConnectivityResult.none) {
                return;
              }
              await FirebaseService.uploadFolder(
                  name: folderNameController.text);
              if (!context.mounted) return;
              Navigator.pop(context);
            }
          },
          child: const Text("Add folder"),
        ),
      ],
      title: Text(
        "New folder",
        style: AppStyles.textStyle(
          fontSize: 14,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: folderNameController,
        autofocus: true,
        style: AppStyles.textStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: "Folder name",
          hintStyle: AppStyles.textStyle(
            fontSize: 12,
            color: AppColors.textColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
