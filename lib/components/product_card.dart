import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    this.isProductsScreen = true,
    required this.productId,
    // required this.product,
    required this.isFavourite,
    required this.id,
    this.isAll = false,
    this.aspectRetio = 1.02,
  }) : super(key: key);

  final double width, aspectRetio;

  final String productId;
  bool isProductsScreen;

  // Map<String, dynamic> product;
  bool isFavourite;
  String id;
  bool isAll;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final height = Get.height;
  final widths = Get.width;

  void updateFavouriteStatus() async {
    final f = FirebaseFirestore.instance
        .collection('products')
        .where('id', isEqualTo: widget.id);

    final docs = await f.get();

    for (var doc in docs.docs) {
      await doc.reference.update(
        {'isFavourite': widget.isFavourite ? false : true},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.isAll
          ? EdgeInsets.all(0)
          : EdgeInsets.only(right: widget.width * 0.12),
      width: widths * 0.36,
      child: StreamBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: [
                  widget.productId,
                  // widget.product['id'],
                ],
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
                        tag: widget.productId,
                        child: Image.network(snapshot.data!.get('images')[0]),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!.get('name'),
                    style: TextStyle(color: Colors.black),
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        snapshot.data!.get('price').toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: widget.isProductsScreen
                            ? () async {
                                final isfav = snapshot.data!.get('isFavourite');
                                await FirebaseFirestore.instance
                                    .collection('products')
                                    .doc(widget.productId)
                                    .update({
                                  'isFavourite': isfav ? false : true,
                                });
                              }
                            : () {},
                        child: widget.isProductsScreen
                            ? Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: snapshot.data!.get('isFavourite')
                                      ? kPrimaryColor.withOpacity(0.15)
                                      : kSecondaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/Heart Icon_2.svg",
                                  height: widget.width * 0.08,
                                  color: snapshot.data!.get('isFavourite')
                                      ? Color(0xFFFF4848)
                                      : Color(0xFFDBDEE4),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                    "assets/icons/Heart Icon_2.svg",
                                    height: widget.width * 0.08,
                                    color: Color(0xFFFF4848)),
                              ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
        stream: FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productId)
            .snapshots(),
      ),
    );
  }
}
