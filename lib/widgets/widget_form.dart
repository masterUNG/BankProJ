// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bankproj/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.labelWidget,
    this.textEditingController,
  }) : super(key: key);

  final Widget? labelWidget;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(controller: textEditingController,
        style: AppConstant().h3Style(),
        decoration: InputDecoration(
          label: labelWidget,
          filled: true,
          fillColor: AppConstant.greyLive,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppConstant.greyLive),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppConstant.greyLive),
              borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        ),
      ),
    );
  }
}
