import 'package:bankproj/states/add_data.dart';
import 'package:bankproj/utility/app_constant.dart';
import 'package:bankproj/utility/app_service.dart';
import 'package:bankproj/widgets/widget_button.dart';
import 'package:bankproj/widgets/widget_icon_button.dart';
import 'package:bankproj/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

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
      floatingActionButton: WidgetButton(
        label: 'Add Data',
        pressFunc: () {
          Get.to(const AddData());
        },
      ),
    );
  }
}
