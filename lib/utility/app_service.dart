// ignore_for_file: avoid_print

import 'package:bankproj/models/mydata_model.dart';
import 'package:bankproj/models/user_model.dart';
import 'package:bankproj/states/main_home.dart';
import 'package:bankproj/utility/app_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class AppService {
  AppController appController = Get.put(AppController());

  String changeDateToString({required DateTime dateTime}) {
    DateFormat dateFormat = DateFormat('dd MMM yy');
    String result = dateFormat.format(dateTime);
    return result;
  }

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
      print('Success signIn value');
      Get.snackbar('SignIn Success', 'Welcome to MyApp');
      Get.offAll(const MainHome());
    }).catchError((onError) {
      Get.snackbar(onError.code, onError.message, backgroundColor: Colors.red);
    });
  }

  Future<void> checkUser() async {
    var user = FirebaseAuth.instance.currentUser;
    String uidLogin = user!.uid;
    print('uidLogin ---> $uidLogin');

    FirebaseFirestore.instance
        .collection('user')
        .doc(uidLogin)
        .get()
        .then((value) {
      print('value -----> ${value.data()}');
      if (value.data() == null) {
        //non Register

        UserModel model =
            UserModel(name: user.displayName ?? '', uid: uidLogin);

        FirebaseFirestore.instance
            .collection('user')
            .doc(uidLogin)
            .set(model.toMap())
            .then((value) {
          print('Register Success');
        });
      } else {
        // Read UserModel
        UserModel model = UserModel.fromMap(value.data()!);
        appController.curentUserModels.add(model);
      }
    });
  }

  Future<void> readMyData() async {
    if (appController.myDataModels.isNotEmpty) {
      appController.myDataModels.clear();
      appController.docIdMyDatas.clear();
    }

    var user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('mydata')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          MyDataModel myDataModel = MyDataModel.fromMap(element.data());
          appController.myDataModels.add(myDataModel);
          appController.docIdMyDatas.add(element.id);
        }
      }
    });
  }

  Future<void> readDetailMyData({required String docIdMyData}) async {
    if (appController.detailMyDataModels.isNotEmpty) {
      appController.detailMyDataModels.clear();
    }

    var user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('mydata')
        .doc(docIdMyData)
        .get()
        .then((value) {
      MyDataModel myDataModel = MyDataModel.fromMap(value.data()!);
      appController.detailMyDataModels.add(myDataModel);
    });
  }
}
