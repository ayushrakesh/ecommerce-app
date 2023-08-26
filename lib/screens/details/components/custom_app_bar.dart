import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CustomAppBar extends StatelessWidget {
  final String productId;

  CustomAppBar({required this.productId});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 20);

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Row(
          children: [
            Container(
              // // width: width * 0.5,
              // height: preferredSize.height,
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 14,
                ),
                // style: IconButton.styleFrom(
                //   padding: EdgeInsets.all(0),
                // ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.004),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  StreamBuilder(
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        final rating = snapshot.data!.get('rating');

                        return Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .doc(productId)
                        .snapshots(),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
