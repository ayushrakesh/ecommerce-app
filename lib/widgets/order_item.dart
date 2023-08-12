import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  List products;
  QueryDocumentSnapshot data;
  String date;
  OrderItem({required this.data, required this.products, required this.date});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  final width = Get.width;
  final height = Get.height;

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Color.fromARGB(255, 196, 195, 195),
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // clipBehavior: Clip.none,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  // Color.fromARGB(255, 9, 161, 14),
                  // Color.fromARGB(255, 85, 196, 89),
                  Color(0xFFEE4E34),
                  Color.fromARGB(255, 249, 133, 115),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: isExpanded
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )
                  : BorderRadius.circular(
                      8,
                    ),
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/Rupee-Symbol-Black.svg',
                      height: height * 0.03,
                    ),
                    Gap(width * 0.008),
                    Text(
                      widget.data['total-amount'].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '${widget.data['number-of-items'].toString()} items',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.date.toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 237, 244, 94)),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/arrow-down-s-line.svg',
                    height: height * 0.06,
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded)
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx, prodindex) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        // Color.fromARGB(255, 9, 161, 14),
                        // Color.fromARGB(255, 85, 196, 89),
                        Color(0xFFEE4E34),
                        Color.fromARGB(255, 249, 133, 115),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: isExpanded
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          )
                        : BorderRadius.circular(
                            8,
                          ),
                  ),
                  padding: EdgeInsets.only(
                    left: width * 0.04,
                    right: width * 0.04,
                    bottom: height * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.products[prodindex]['product-name'],
                        style: const TextStyle(
                          color: Color(0xFFFCEDDA),
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'x${widget.data['products'][prodindex]['product-quantity'].toString()}',
                        style: const TextStyle(
                          color: Color(0xFFFCEDDA),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: widget.products.length,
            ),
        ],
      ),
    );
  }
}
