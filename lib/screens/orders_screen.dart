import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  static const routename = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final width = Get.width;

  final height = Get.height;

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Orders",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w300,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.03,
          horizontal: width * 0.05,
        ),
        child: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  final data = snapshot.data!.docs[index];
                  final date = DateFormat('dd-MM-yyyy')
                      .format(DateTime.tryParse(data['created-at'])!);
                  final products = data['products'];
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
                                ? BorderRadius.only(
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
                                    data['total-amount'].toString(),
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
                                    '${data['number-of-items'].toString()} items',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    date.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 237, 244, 94)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      products[prodindex]['product-name'],
                                      style: const TextStyle(
                                        color: Color(0xFFFCEDDA),
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      'x${data['products'][index]['product-quantity'].toString()}',
                                      style: const TextStyle(
                                        color: Color(0xFFFCEDDA),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: products.length,
                          ),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
            return const CircularProgressIndicator();
          },
          stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        ),
      ),
    );
  }
}
