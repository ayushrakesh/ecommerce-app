import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:ecommerce_app/screens/login_success/login_success_screen.dart';
import 'package:ecommerce_app/screens/orders_screen.dart';
import 'package:ecommerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce_app/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final height = Get.height;
  final width = Get.width;

  File? pickedimg;

  bool isloading = false;
  String userImageurl = '';

  final userId = FirebaseAuth.instance.currentUser!.uid;

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
                Navigator.of(context).popAndPushNamed(SplashScreen.routeName);
                // .pushReplacementNamed(SignInScreen.routeName);
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

  Future<void> getUserImageUrl() async {
    final currentuserId = FirebaseAuth.instance.currentUser!.uid;

    setState(() {
      isloading = true;
    });
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentuserId)
        .get();
    setState(() {
      isloading = false;
    });

    final userDoc = userData.data();

    setState(() {
      userImageurl = userDoc!['image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
              height: height * 0.2,
              width: height * 0.2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: StreamBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.data()!['image'] != null) {
                      return Image.network(snapshot.data!.data()!['image']);
                    }
                    return Image.asset('assets/images/user.png');
                  }
                  return const CircularProgressIndicator();
                },
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .snapshots(),
              )),
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
