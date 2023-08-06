import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: height * 0.05,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
          ),
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
