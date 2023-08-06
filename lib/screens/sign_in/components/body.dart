import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../components/no_account_text.dart';
import '../../../components/socal_card.dart';
import '../../../size_config.dart';
import 'sign_form.dart';
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
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(height * 0.02),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(height * 0.01),
                const Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                Gap(height * 0.03),
                SignForm(),
                Gap(height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(flex: 2),
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    Spacer(flex: 1),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    Spacer(flex: 1),
                    SocalCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                Gap(height * 0.03),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
