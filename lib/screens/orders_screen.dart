import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  static const routename = '/orders';

  final width = Get.width;
  final height = Get.height;

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
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 9, 161, 14),
                          Color.fromARGB(255, 85, 196, 89),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    width: double.infinity,
                    // height: height * 0.4,
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
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(${DateF})
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            print('tapped');
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/arrow-down-s-line.svg',
                            height: height * 0.06,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
            return CircularProgressIndicator();
          },
          stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        ),
      ),
    );
  }
}
