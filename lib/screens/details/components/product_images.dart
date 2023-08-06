import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  Map<String, dynamic> product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width * 0.6,
          height: height * 0.3,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product['id'],
              child: Image.network(
                widget.product['images'][selectedImage],
              ),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.product['images'].length,
                (index) => buildSmallProductPreview(index)),
          ],
        ),
        Gap(height * 0.03)
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(
          widget.product['images'][index],
          height: height * 0.05,
          width: height * 0.05,
        ),
      ),
    );
  }
}
