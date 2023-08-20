// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bankproj/models/mydata_model.dart';
import 'package:bankproj/utility/app_constant.dart';
import 'package:bankproj/utility/app_service.dart';
import 'package:bankproj/widgets/widget_form.dart';
import 'package:bankproj/widgets/widget_text.dart';
import 'package:bankproj/widgets/widget_text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  final String title;
  AppDialog({
    required this.title,
  });

  void confirmDialog({Widget? confirmWidget}) {
    Get.dialog(AlertDialog(
      title: WidgetText(
        data: title,
        textStyle: AppConstant().h2Style(),
      ),
      actions: [
        confirmWidget ?? const SizedBox(),
        WidgetTextButton(
          label: 'Cancel',
          pressFunc: () {
            Get.back();
          },
        )
      ],
    ));
  }

  void editTitleDialog(
      {required String docIdMyData, required MyDataModel myDataModel}) {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = myDataModel.title;

    Get.dialog(AlertDialog(
      title: WidgetText(data: title),
      content: WidgetForm(
        textEditingController: textEditingController,
      ),
      actions: [
        WidgetTextButton(
          label: 'Edit',
          pressFunc: () async {
            Map<String, dynamic> map = myDataModel.toMap();
            map['title'] = textEditingController.text;

            var user = FirebaseAuth.instance.currentUser;

            FirebaseFirestore.instance
                .collection('user')
                .doc(user!.uid)
                .collection('mydata')
                .doc(docIdMyData)
                .update(map)
                .then((value) {
              AppService().readDetailMyData(docIdMyData: docIdMyData);
              Get.back();
            });
          },
        ),
        WidgetTextButton(
          label: 'Cancel',
          pressFunc: () {
            Get.back();
          },
        ),
      ],
    ));
  }
}
