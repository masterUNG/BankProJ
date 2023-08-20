// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bankproj/utility/app_controller.dart';
import 'package:bankproj/utility/app_dialog.dart';
import 'package:bankproj/utility/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:bankproj/models/mydata_model.dart';
import 'package:bankproj/utility/app_constant.dart';
import 'package:bankproj/widgets/widget_icon_button.dart';
import 'package:bankproj/widgets/widget_text.dart';

class DetailData extends StatefulWidget {
  const DetailData({
    Key? key,
    required this.docIdMyData,
  }) : super(key: key);

  final String docIdMyData;

  @override
  State<DetailData> createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().readDetailMyData(docIdMyData: widget.docIdMyData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          data: 'Detail Data',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: Obx(() {
        return appController.detailMyDataModels.isEmpty
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const WidgetText(data: 'Title :'),
                            WidgetText(
                                data: appController
                                    .detailMyDataModels.last.title),
                            const Spacer(),
                            WidgetIconButton(
                              iconData: Icons.edit,
                              pressFunc: () {
                                AppDialog(title: 'Edit Title').editTitleDialog(
                                  docIdMyData: widget.docIdMyData,
                                  myDataModel:
                                      appController.detailMyDataModels.last,
                                );
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const WidgetText(data: 'Detail :'),
                            WidgetText(
                                data: appController
                                    .detailMyDataModels.last.detail),
                            const Spacer(),
                            WidgetIconButton(
                              iconData: Icons.edit,
                              pressFunc: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
