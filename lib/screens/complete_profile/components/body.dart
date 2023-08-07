import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../profile/components/profile_pic.dart';
import 'complete_profile_form.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  final height = Get.height;
  final width = Get.width;

  File? pickedimg;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(height * 0.03),
                ProfilePic(pickedimg),
                Gap(height * 0.026),
                CompleteProfileForm(pickedimg),
                Gap(height * 0.03),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
