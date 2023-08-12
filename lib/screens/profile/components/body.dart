import 'dart:io';
import 'package:ecommerce_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:ecommerce_app/screens/orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final height = Get.height;
  final width = Get.width;

  File? pickedimg;

  void showDialogBox(BuildContext ctx) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          content: const Text(
            'Confirm !',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            const Spacer(flex: 1),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text('Yes'),
            ),
            const Spacer(
              flex: 2,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('No')),
            const Spacer(flex: 1),
          ],
          actionsPadding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          actionsAlignment: MainAxisAlignment.spaceBetween,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(pickedimg),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.of(context).pushNamed(CompleteProfileScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "My Orders",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.of(context).pushNamed(OrdersScreen.routename);
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              showDialogBox(context);
            },
          ),
        ],
      ),
    );
  }
}
