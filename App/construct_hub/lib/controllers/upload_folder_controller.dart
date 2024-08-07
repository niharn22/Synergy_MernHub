import 'package:construct_hub/core/utils/app_values.dart';
import 'package:construct_hub/models/file_model.dart';
import 'package:construct_hub/models/folder_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';

class FilesAndFolderController extends GetxController {
  RxList<FolderModel> foldersList = <FolderModel>[].obs;
  RxList<FileModel> recentFiles = <FileModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    recentFiles.bindStream(AppValues.userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("files")
        .orderBy("date_uploaded", descending: true)
        .limit(25)
        .snapshots()
        .map((querySnapShot) {
      final List<FileModel> files = [];
      for (var doc in querySnapShot.docs) {
        files.add(FileModel.fromFireStore(fireStoreData: doc.data()));
      }
      return files;
    }));

    foldersList.bindStream(
      AppValues.userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("folders")
          .orderBy("date_created", descending: true)
          .snapshots()
          .map((querySnapShot) {
        final List<FolderModel> folders = [];

        for (var doc in querySnapShot.docs) {
          folders.add(FolderModel.fromDocumentSnapShot(doc));
        }
        return folders;
      }),
    );
  }
}
