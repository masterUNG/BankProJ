import 'package:bankproj/models/mydata_model.dart';
import 'package:bankproj/utility/app_constant.dart';
import 'package:bankproj/utility/app_controller.dart';
import 'package:bankproj/utility/app_service.dart';
import 'package:bankproj/utility/app_snackbar.dart';
import 'package:bankproj/widgets/widget_button.dart';
import 'package:bankproj/widgets/widget_form.dart';
import 'package:bankproj/widgets/widget_icon_button.dart';
import 'package:bankproj/widgets/widget_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          data: 'Add Data',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      WidgetForm(
                        textEditingController: titleController,
                        labelWidget: const WidgetText(data: 'Title :'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      WidgetForm(
                        textEditingController: detailController,
                        labelWidget: const WidgetText(data: 'Detail :'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      aboutStartEnd(),
                      addDataButton(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox addDataButton() {
    return SizedBox(
      width: 250,
      child: WidgetButton(
        label: 'Add Data',
        pressFunc: () {
          if ((titleController.text.isEmpty) ||
              (detailController.text.isEmpty)) {
            //Have Space
            AppSnackBar(
                    title: 'Have Space?', message: 'Please Fill Every Blank')
                .errorSnackbar();
          } else if (appController.startDateTimes.isEmpty) {
            //non Choose Start
            AppSnackBar(
                    title: 'Start Date?', message: 'Please Choose Start Date')
                .errorSnackbar();
          } else if (appController.endDateTimes.isEmpty) {
            AppSnackBar(title: 'End Date?', message: 'Please Choose End Date')
                .errorSnackbar();
          } else {
            MyDataModel myDataModel = MyDataModel(
                title: titleController.text,
                detail: detailController.text,
                start: Timestamp.fromDate(appController.startDateTimes.last),
                end: Timestamp.fromDate(appController.endDateTimes.last),
                timestamp: Timestamp.fromDate(DateTime.now()));

            FirebaseFirestore.instance
                .collection('user')
                .doc(appController.curentUserModels.last.uid)
                .collection('mydata')
                .doc()
                .set(myDataModel.toMap())
                .then((value) {
              Get.back();
              AppSnackBar(
                      title: 'Add Data Success', message: 'Add Data Success')
                  .normalSnackbar();
            });
          }
        },
      ),
    );
  }

  Row aboutStartEnd() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return appController.startDateTimes.isEmpty
                  ? const WidgetText(data: 'Start')
                  : WidgetText(
                      data: AppService().changeDateToString(
                          dateTime: appController.startDateTimes.last));
            }),
            WidgetIconButton(
              iconData: Icons.calendar_month,
              pressFunc: () async {
                DateTime dateTime = DateTime.now();

                await showDatePicker(
                        context: context,
                        initialDate: dateTime,
                        firstDate: DateTime(dateTime.year - 2),
                        lastDate: DateTime(dateTime.year + 2))
                    .then((value) {
                  DateTime? startDateTime = value;
                  print('startDatetime ---> $startDateTime');

                  if (startDateTime != null) {
                    appController.startDateTimes.add(startDateTime);
                  }
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return appController.endDateTimes.isEmpty
                  ? const WidgetText(data: 'End')
                  : WidgetText(
                      data: AppService().changeDateToString(
                          dateTime: appController.endDateTimes.last));
            }),
            WidgetIconButton(
              iconData: Icons.calendar_month,
              pressFunc: () async {
                DateTime dateTime = DateTime.now();
                await showDatePicker(
                        context: context,
                        initialDate: dateTime,
                        firstDate: DateTime(dateTime.year - 2),
                        lastDate: DateTime(dateTime.year + 2))
                    .then((value) {
                  if (value != null) {
                    appController.endDateTimes.add(value);
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
