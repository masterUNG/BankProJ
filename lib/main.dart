// ignore_for_file: avoid_print

import 'package:bankproj/states/authen.dart';
import 'package:bankproj/states/main_home.dart';
import 'package:bankproj/utility/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: AppConstant.pageAuthen,
    page: () => const Authen(),
  ),
  GetPage(
    name: AppConstant.pageMainHome,
    page: () => const MainHome(),
  ),
];

String? firstPage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      print('##### event ---> $event');

      if (event == null) {
        // ไม่ได้ SignIn
        firstPage = AppConstant.pageAuthen;
        runApp(const MyApp());
      } else {
        //Sing In
        firstPage = AppConstant.pageMainHome;
        runApp(const MyApp());
      }
    });
  }).catchError((onError) {
    print(onError);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: getPages,
      initialRoute: firstPage ?? '/authen',
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
