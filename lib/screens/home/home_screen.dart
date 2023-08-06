import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.04,
              horizontal: width * 0.04,
            ),
            child: Column(
              children: [
                // SizedBox(height: height * 0.05),
                HomeHeader(),
                SizedBox(height: height * 0.04),
                DiscountBanner(),
                Gap(height * 0.03),
                Categories(),
                Gap(height * 0.04),
                SpecialOffers(),
                Gap(height * 0.04),
                PopularProducts(),
                // SizedBox(height: height * 0.08),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
