import 'package:bankproj/utility/app_constant.dart';
import 'package:bankproj/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class AddData extends StatelessWidget {
  const AddData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: WidgetText(data: 'Add Data', textStyle: AppConstant().h2Style(),),),);
  }
}