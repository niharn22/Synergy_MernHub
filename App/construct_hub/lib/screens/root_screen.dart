import 'package:construct_hub/controllers/auth_controller.dart';
import 'package:construct_hub/screens/home_screen.dart';
import 'package:construct_hub/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});
  final AuthController authController =
      Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(authController.user);
      return authController.user.value == null ? LoginScreen() : HomeScreen();
    });
  }
}
