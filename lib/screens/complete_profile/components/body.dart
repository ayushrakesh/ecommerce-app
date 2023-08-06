import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'complete_profile_form.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  final height = Get.height;
  final width = Get.width;

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
                // Text("Complete Profile", style: headingStyle),
                Text(
                  "Complete your details or continue  \nwith social media",
                  textAlign: TextAlign.center,
                ),
                Gap(height * 0.02),
                CompleteProfileForm(),
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
