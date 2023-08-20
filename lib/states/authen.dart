import 'package:bankproj/utility/app_constant.dart';
import 'package:bankproj/utility/app_service.dart';
import 'package:bankproj/widgets/widget_form.dart';
import 'package:bankproj/widgets/widget_image_asset.dart';
import 'package:bankproj/widgets/widget_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    buildTop(),
                    const SizedBox(
                      height: 16,
                    ),
                    SignInButton(Buttons.Google, onPressed: () {
                      AppService().processSignInWithGmail();
                    })
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildTop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const WidgetImageAsset(
          width: 150,
        ),
        const SizedBox(
          width: 8,
        ),
        WidgetText(
          data: AppConstant.appName,
          textStyle: AppConstant().h1Style(size: 25),
        )
      ],
    );
  }
}
