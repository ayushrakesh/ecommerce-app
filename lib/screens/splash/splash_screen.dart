import 'package:ecommerce_app/screens/splash/components/body.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../cart/components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: SplashBody(),
    );
  }
}
