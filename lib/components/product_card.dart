import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../models/Product.dart';
import '../screens/details/details_screen.dart';
import '../size_config.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    Key? key,
    this.width = 140,
    required this.product,
    this.isAll = false,
    this.aspectRetio = 1.02,
  }) : super(key: key);

  final double width, aspectRetio;

  Map<String, dynamic> product;

  bool isAll;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final height = Get.height;

  final widths = Get.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.isAll
          ? EdgeInsets.all(0)
          : EdgeInsets.only(right: widget.width * 0.12),
      width: widths * 0.36,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: widget.product,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.width * 0.02,
                  vertical: height * 0.04,
                ),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Hero(
                  tag: widget.product['id'],
                  child: Image.network('${widget.product['images'][0]}'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.product['name'],
              style: TextStyle(color: Colors.black),
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.product['price']}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      widget.product['isFavourite'] =
                          !widget.product['isFavourite'];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: widget.product['isFavourite']
                          ? kPrimaryColor.withOpacity(0.15)
                          : kSecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      height: widget.width * 0.08,
                      color: widget.product['isFavourite']
                          ? Color(0xFFFF4848)
                          : Color(0xFFDBDEE4),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
