import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/cart/cart_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';
import '../../../components/default_button.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  Map<String, dynamic> product;

  String id;

  Body({Key? key, required this.product, required this.id}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final height = Get.height;
  final width = Get.width;

  bool isLoading = false;
  bool isInBasket = false;

  void addToCart() async {
    setState(() {
      isLoading = true;
    });

    if (!widget.product['is-in-basket']) {
      final docRF = await FirebaseFirestore.instance.collection('cart').add({
        'id': widget.product['id'],
        'name': widget.product['name'],
        'price': widget.product['price'],
        'quantity': 1,
        'image': widget.product['images'][0],
      });

      final productToUpdate = FirebaseFirestore.instance
          .collection('products')
          .where('id', isEqualTo: widget.product['id']);

      var d = await productToUpdate.get();

      for (var doc in d.docs) {
        await doc.reference.update({'is-in-basket': true});
      }

      setState(() {
        isInBasket = true;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: const Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        // left: width * 0.04,
                        top: height * 0.01,
                      ),
                      child: ColorDots(product: widget.product),
                    ),
                    Gap(height * 0.02),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          bottom: height * 0.02
                          // : height * 0.04,
                          ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.deepOrange,
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                ),
                                backgroundColor: widget.product['is-in-basket']
                                    ? Color.fromARGB(255, 6, 15, 140)
                                    : const Color(0xFFFF7643),
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.35,
                                  vertical: height * 0.018,
                                ),
                              ),
                              onPressed: isInBasket ? () {} : addToCart,
                              child: widget.product['is-in-basket']
                                  ? const Text(
                                      'Is in Basket',
                                      style: TextStyle(
                                        letterSpacing: 0.4,
                                      ),
                                    )
                                  : const Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                          // letterSpacing: 0.4,
                                          ),
                                    ),
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
