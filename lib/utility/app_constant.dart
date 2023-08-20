import 'package:flutter/material.dart';

class AppConstant {
  
  static String pageAuthen = '/authen';
  static String pageMainHome = '/mainHome';

  static String appName = 'Ung Calendar';
  static Color greyLive = Colors.grey.shade300;

  TextStyle h1Style({double? size}) {
    return TextStyle(
      fontSize: size ?? 36,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style({double? size}) {
    return TextStyle(
      fontSize: size ?? 24,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }
}
