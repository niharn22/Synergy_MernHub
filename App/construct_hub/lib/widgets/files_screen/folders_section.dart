import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construct_hub/controllers/upload_folder_controller.dart';
import 'package:construct_hub/core/firebase_services/firebase_services.dart';
import 'package:construct_hub/core/utils/app_assets.dart';
import 'package:construct_hub/core/utils/app_colors.dart';
import 'package:construct_hub/core/utils/app_styles.dart';
import 'package:construct_hub/screens/display_files_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoldersSection extends StatelessWidget {
  const FoldersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GetX<FilesAndFolderController>(builder: (controller) {
        if (controller != null && controller.foldersList != null) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.foldersList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(
                      DisplayFilesScreen(
                        title: controller.foldersList[index].folderName,
                        type: "folder",
                        folderId: controller.foldersList[index].id,
                      ),
                      transition: Transition.leftToRightWithFade);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          offset: const Offset(10, 10),
                          blurRadius: 3),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center text and icon
                    children: [
                      Expanded(
                        child: ClipRRect(
                          // Clip the image with rounded corners
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            AppAssets.foldersPath,
                            fit: BoxFit.cover, // Adjust the BoxFit property
                          ),
                        ),
                      ),
                      const SizedBox(height: 0), // Add space between image and text
                      Text(
                        controller.foldersList[index].folderName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center, // Center text
                        style: AppStyles.textStyle(
                          fontSize: 12,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseService.getFoldersSnapShot(
                              folderId: controller.foldersList[index].id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                "${snapshot.data?.docs.length ?? 0} files",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center, // Center text
                                style: AppStyles.textStyle(
                                  fontSize: 10,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            } else {
                              return Text(
                                "0 files",
                                style: AppStyles.textStyle(
                                  fontSize: 10,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}
