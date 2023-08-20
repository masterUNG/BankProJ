import 'package:bankproj/utility/app_constant.dart';
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(style: AppConstant().h3Style(),
        decoration: InputDecoration(
            filled: true,
            fillColor: AppConstant.greyLive,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppConstant.greyLive),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppConstant.greyLive),
                borderRadius: BorderRadius.circular(10)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
      ),
    );
  }
}
