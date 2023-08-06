import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../components/default_button.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  Map<String, dynamic> product;

  Body({Key? key, required this.product}) : super(key: key);

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        // left: width * 0.04,
                        top: height * 0.01,
                      ),
                      child: ColorDots(product: product),
                    ),
                    Gap(height * 0.02),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          bottom: height * 0.02
                          // : height * 0.04,
                          ),
                      child: DefaultButton(
                        text: "Add To Cart",
                        press: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
