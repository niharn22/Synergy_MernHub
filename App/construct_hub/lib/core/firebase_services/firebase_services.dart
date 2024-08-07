import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construct_hub/core/utils/app_values.dart';
import 'package:construct_hub/core/utils/helper_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

class FirebaseService {
  static Future<void> uploadFolder({required String name}) async {
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getFoldersSnapShot(
      {required String folderId}) async* {
    yield* AppValues.userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("files")
        .where("folder_id", isEqualTo: folderId)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getFilesForSelectedFolder(
      {required String folderId}) async* {
    yield* AppValues.userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("files")
        // .orderBy("size", descending: true)
        .where("folder_id", isEqualTo: folderId)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getFilesAccordingToType(
      {required String fileType}) async* {
    bool isDoc =
        fileType != "video" && fileType != "audio" && fileType != "image";
    if (isDoc) {
      yield* AppValues.userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("files")
          // .orderBy("size", descending: true)
          .where("file_type",
              whereNotIn: ["video", "audio", "image"]).snapshots();
    } else {
      yield* AppValues.userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("files")
          // .orderBy("size", descending: true)
          .where("file_type", isEqualTo: fileType)
          .snapshots();
    }
  }

  static uploadFile({required String folderId}) async {
    List<File> files = [];
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    // Getting the file paths and adding them to List
    if (result != null) {
      for (var path in result.paths) {
        files.add(File(path!));
      }

      // Getting filetype, fileName and extension
      for (var file in files) {
        String? fileType = lookupMimeType(file.path);
        // Getting filetype for example image
        String? filteredFileType = fileType!.split("/")[0];

        List<String?> pathParts = file.path.split("/");
        String? fileName = pathParts.last;
        String? extenstion = fileName?.split(".").last;
        late File compressedFile;

        if (filteredFileType == "image") {
          compressedFile = await AppHelpersFunctions.compressImage(file);
        } else if (filteredFileType == "video") {
          compressedFile = await AppHelpersFunctions.compressVideo(file);
        } else {
          compressedFile = file;
        }

        int length = await AppValues.userCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("files")
            .get()
            .then((value) => value.docs.length);
        //  Uploading file to storage
        // log("FileType: ${fileType}");
        // log("filteredFileType: ${filteredFileType}");
        // log("pathParts: ${pathParts}");
        // log("fileName: ${fileName}");
        // log("extenstion: ${extenstion}");
        // log("compressedFile: ${compressedFile}");
        Get.snackbar(
          "Uploading file.",
          "This my take sometime, please wait.",
        );
        await uploadToFireStorage(
            file: compressedFile,
            length: length,
            type: fileType,
            fileName: fileName!,
            filteredFileType: filteredFileType,
            extenstion: extenstion!,
            folderId: folderId,
            fileSize: ((compressedFile.readAsBytesSync()).lengthInBytes / 1024)
                .round());
      }
    }
    Get.closeCurrentSnackbar();
    Get.snackbar("File uploaded.", "Thank your for your patience.");
  }

  // Compress files function

  static Future<void> uploadToFireStorage({
    required File file,
    required int length,
    required String type,
    required String fileName,
    required String filteredFileType,
    required String extenstion,
    required String folderId,
    required int fileSize,
  }) async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("files")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(fileName)
        .putFile(file, SettableMetadata(contentType: type));
    // uploadTask.snapshotEvents.listen((event) {
    //   print(object);
    // });
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String fileUrl = await taskSnapshot.ref.getDownloadURL();
    // Saving data in firestore for each user
    await saveDataInFireStare(
        fileUrl: fileUrl,
        fileName: fileName,
        filteredFileType: filteredFileType,
        extenstion: extenstion,
        folderId: folderId,
        fileSize: fileSize);
  }

  static saveDataInFireStare({
    required String fileUrl,
    required String fileName,
    required String filteredFileType,
    required String extenstion,
    required String folderId,
    required int fileSize,
  }) async {
    final tempDoc = AppValues.userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("files")
        .doc();

    await tempDoc.set({
      "file_id": tempDoc.id,
      "file_url": fileUrl,
      "file_name": fileName,
      "file_type": filteredFileType,
      "file_extenstion": extenstion,
      "folder_id": folderId,
      "file_size": fileSize,
      "date_uploaded": FieldValue.serverTimestamp(),
    });
  }

  // Downloading File
}
