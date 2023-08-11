import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  final height = Get.height;
  final width = Get.width;

  num total = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 174,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  // height: getProportionateScreenWidth(40),
                  // width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            Gap(height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Total'),
                    Gap(height * 0.03),
                    SizedBox(
                      height: 50,
                      width: width * 0.7,
                      child: StreamBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            num totalAmount = 0;
                            var docs = snapshot.data!.docs;
                            docs.forEach((element) {
                              totalAmount = totalAmount +
                                  (element.data()['quantity']) *
                                      (element.data()['price']);
                            });

                            total = totalAmount;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * 0.2,
                                  child: Text(
                                    totalAmount.toStringAsFixed(2),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                // SizedBox(width: width*0.04),
                                SizedBox(
                                  width: width * 0.4,
                                  height: height * 0.1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Buy Now",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        PaymentScreen.routeName,
                                        arguments: [total, snapshot],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                          return CircularProgressIndicator();
                        },
                        stream: FirebaseFirestore.instance
                            .collection('cart')
                            .snapshots(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
