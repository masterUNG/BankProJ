import 'package:bankproj/states/add_data.dart';
import 'package:bankproj/states/detail_data.dart';
import 'package:bankproj/utility/app_constant.dart';
import 'package:bankproj/utility/app_controller.dart';
import 'package:bankproj/utility/app_dialog.dart';
import 'package:bankproj/utility/app_service.dart';
import 'package:bankproj/widgets/widget_button.dart';
import 'package:bankproj/widgets/widget_icon_button.dart';
import 'package:bankproj/widgets/widget_text.dart';
import 'package:bankproj/widgets/widget_text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().checkUser().then((value) {
      AppService().readMyData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          data: 'Main Home',
          textStyle: AppConstant().h2Style(),
        ),
        actions: [
          WidgetIconButton(
            iconData: Icons.exit_to_app,
            pressFunc: () {
              AppService()
                  .processSignOut()
                  .then((value) => Get.offAllNamed(AppConstant.pageAuthen));
            },
          )
        ],
      ),
      body: Obx(() {
        return appController.myDataModels.isEmpty
            ? const SizedBox()
            : ListView.builder(
                itemCount: appController.myDataModels.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.to(DetailData(
                      docIdMyData: appController.docIdMyDatas[index],
                    ))!
                        .then((value) => AppService().readMyData());
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WidgetText(
                                data: appController.myDataModels[index].title,
                                textStyle: AppConstant().h2Style(size: 18),
                              ),
                              WidgetIconButton(
                                iconData: Icons.delete_forever,
                                pressFunc: () async {
                                  AppDialog(title: 'Confirm Delete')
                                      .confirmDialog(
                                          confirmWidget: WidgetTextButton(
                                    label: 'Confirm Delete',
                                    pressFunc: () {
                                      var user =
                                          FirebaseAuth.instance.currentUser;
                                      FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(user!.uid)
                                          .collection('mydata')
                                          .doc(
                                              appController.docIdMyDatas[index])
                                          .delete()
                                          .then((value) {
                                        Get.back();
                                        return AppService().readMyData();
                                      });
                                    },
                                  ));
                                },
                              ),
                            ],
                          ),
                          WidgetText(
                              data: appController.myDataModels[index].detail),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WidgetText(
                                  data:
                                      'Start : ${AppService().changeDateToString(dateTime: appController.myDataModels[index].start.toDate())}'),
                              WidgetText(
                                  data:
                                      'End : ${AppService().changeDateToString(dateTime: appController.myDataModels[index].end.toDate())}')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      }),
      floatingActionButton: WidgetButton(
        label: 'Add Data',
        pressFunc: () {
          Get.to(const AddData())!.then((value) => AppService().readMyData());
        },
      ),
    );
  }
}
