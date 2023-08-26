import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class IconBtnWithCounterOrders extends StatelessWidget {
  IconBtnWithCounterOrders({
    Key? key,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String svgSrc;

  final GestureTapCallback press;

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(
              height * 0.015,
            ),
            height: height * 0.06,
            width: height * 0.06,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgSrc),
          ),
          Positioned(
            top: -3,
            right: 0,
            child: Container(
              height: height * 0.025,
              width: height * 0.025,
              decoration: BoxDecoration(
                color: Color(0xFFFF4848),
                shape: BoxShape.circle,
                border: Border.all(width: 1.5, color: Colors.white),
              ),
              child: Center(
                child: StreamBuilder(
                  builder: (ctx, snapshot) {
                    num orders = snapshot.data!.docs.length;

                    if (snapshot.hasData) {
                      return Text(
                        orders.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .snapshots(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
