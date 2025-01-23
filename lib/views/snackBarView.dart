import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SnackBarView{
  void showSnackBarUsingGetX({required String title, required String message, required Color color, required IconData icon}){
    Get.snackbar(
        title,
        message,
        //duration: const Duration(seconds: 2),
        maxWidth: Get.width * .6,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: color,
        colorText: Colors.white,
        icon:  Icon(
          icon,
          color: Colors.white,
        ));
  }
}