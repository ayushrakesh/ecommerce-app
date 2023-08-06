import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../size_config.dart';

class RoundedIconBtn extends StatelessWidget {
  RoundedIconBtn({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.08,
      width: width * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          shadowColor: Colors.grey,
          elevation: 15,
        ),
        padding: EdgeInsets.all(0),
        icon: Icon(
          icon,
          size: 18,
        ),
        onPressed: press,
      ),
    );
  }
}
