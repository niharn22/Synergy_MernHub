import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:construct_hub/controllers/files_controller.dart';
import 'package:construct_hub/core/firebase_services/firebase_services.dart';
// import 'package:construct_hub/core/utils/app_assets.dart';
// import 'package:construct_hub/core/utils/app_styles.dart';
import 'package:construct_hub/models/file_model.dart';
import 'package:construct_hub/widgets/display_files_screen/files_grid_view.dart';
// import 'package:construct_hub/widgets/files_screen/custom_image_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DisplayFilesScreen extends StatelessWidget {
  final String title;
  final String type;
  final String folderId;
  // وتستعمل بقي او بي اكس تحت
  // FilesController filesController = Get.find<FilesController>();
  const DisplayFilesScreen(
      {super.key,
      required this.title,
      required this.type,
      required this.folderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == "folder" ? "$title (Folder)" : title),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () async {
          await FirebaseService.uploadFile(folderId: folderId);
        },
        child: const Icon(
          EvaIcons.fileAdd,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: type == "folder"
              ? FirebaseService.getFilesForSelectedFolder(folderId: folderId)
              : FirebaseService.getFilesAccordingToType(fileType: type),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Column(
                  children: [
                    const Text("Couldn't get data, please try again later."),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange,
                      ),
                      onPressed: () {
                        FirebaseService.getFilesForSelectedFolder(
                            folderId: folderId);
                      },
                      child: const Text("Try again"),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              List<FileModel> files = [];
              for (var doc in snapshot.data!.docs) {
                files.add(FileModel.fromFireStore(fireStoreData: doc.data()));
              }

              return FilesGridView(
                files: files,
              );
            }
            return const SizedBox();
          }),
    );
  }
}
