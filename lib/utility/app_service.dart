// ignore_for_file: avoid_print

import 'package:bankproj/states/main_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppService {
  Future<void> processSignOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> processSignInWithGmail() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    await FirebaseAuth.instance
        .signInWithCredential(oAuthCredential)
        .then((value) {
      print('Success signIn');
      Get.snackbar('SignIn Success', 'Welcome to MyApp');
      Get.offAll(const MainHome());
    }).catchError((onError) {
      Get.snackbar(onError.code, onError.message, backgroundColor: Colors.red);
    });
  }
}
