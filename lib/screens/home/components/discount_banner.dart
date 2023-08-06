import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  DiscountBanner({
    Key? key,
  }) : super(key: key);

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      // height: height * 0.06,
      width: double.infinity,
      // margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.032,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "A Summer Surpise\n"),
            TextSpan(
              text: "Cashback 20%",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
