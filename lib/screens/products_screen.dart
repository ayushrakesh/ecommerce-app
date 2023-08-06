import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = '/products';

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Products",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w300,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: StreamBuilder(
            builder: (context, snapshot) {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: width * 0.03,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    return ProductCard(
                      product: snapshot.data!.docs[index].data(),
                      isAll: true,
                    );
                  }
                  return const CircularProgressIndicator();
                },
              );
            },
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
          ),
        ),
      ),
    );
  }
}
