import 'package:construct_hub/controllers/custom_tab_controller.dart';
import 'package:construct_hub/screens/dwgtopdf_screen.dart';
import 'package:construct_hub/screens/files_screen.dart';
import 'package:construct_hub/widgets/files_screen/add_folder_dialog.dart';
import 'package:construct_hub/widgets/home_screen/home_header.dart';
import 'package:construct_hub/screens/storage_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});

  final CustomTabController tabController =
      Get.put<CustomTabController>(CustomTabController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          GetBuilder<CustomTabController>(builder: (controller) {
        return controller.tab != "storage"
            ? FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AddFolderDialog();
                    },
                  );
                },
                child: Icon(
                  EvaIcons.folderAdd,
                ),
              )
            : SizedBox();
      }),
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.deepOrange,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Navigate to the desired screen here
                // For example:
                Get.to(DwgtoPdfScreen());
              },
              icon: Icon(
                Icons.view_in_ar_sharp,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(30),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(),
            GetBuilder<CustomTabController>(builder: (controller) {
              return controller.tab == "storage"
                  ? StorageScreen()
                  : FilesScreen();
            }),
          ],
        ),
      ),
    );
  }
}
