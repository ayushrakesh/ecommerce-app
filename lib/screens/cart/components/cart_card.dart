import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../components/rounded_icon_btn.dart';
import '../../../constants.dart';
import '../../../models/Cart.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  CartCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  QueryDocumentSnapshot cartItem;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final height = Get.height;
  final width = Get.width;

  void quantityIncrease() async {
    await widget.cartItem.reference.update({
      'quantity': widget.cartItem['quantity'] + 1,
    });
  }

  void quantityDecrease() async {
    if (widget.cartItem['quantity'] > 1) {
      await widget.cartItem.reference.update({
        'quantity': widget.cartItem['quantity'] - 1,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                '${widget.cartItem['image']}',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Gap(height * 0.026),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cartItem['name'],
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            Gap(height * 0.01),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: "\$${widget.cartItem['price'].toString()}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " x${widget.cartItem['quantity'].toString()}",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
                // Spacer(),
                Gap(width * 0.2),
                Row(
                  children: [
                    RoundedIconBtn(
                      icon: Icons.remove,
                      showShadow: true,
                      press: quantityDecrease,
                    ),
                    SizedBox(width: width * 0.03),
                    RoundedIconBtn(
                      icon: Icons.add,
                      showShadow: true,
                      press: quantityIncrease,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
