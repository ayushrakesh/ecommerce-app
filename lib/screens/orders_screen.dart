import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/widgets/order_item.dart';
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
                  return OrderItem(products: products, data: data, date: date);
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
