// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  final String title;
  final String message;
  AppSnackBar({
    required this.title,
    required this.message,
  });

  void normalSnackbar(){
    Get.snackbar(title, message);
  }

  void errorSnackbar(){
    Get.snackbar(title, message, backgroundColor: Colors.red.shade700, colorText: Colors.white);
  }


  
}
