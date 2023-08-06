import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final height = Get.height;
  final width = Get.width;

  String? search;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: width * 0.6,
          child: TextField(
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
              ),
              filled: true,
              prefixIconColor: Colors.grey.shade700,
              focusedBorder: InputBorder.none,
              fillColor: Colors.grey.shade200,
              hintText: "Search product",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        IconBtnWithCounter(
          svgSrc: "assets/icons/Cart Icon.svg",
          press: () => Navigator.pushNamed(context, CartScreen.routeName),
        ),
        IconBtnWithCounter(
          svgSrc: "assets/icons/Bell.svg",
          numOfitem: 3,
          press: () {},
        ),
      ],
    );
  }
}
