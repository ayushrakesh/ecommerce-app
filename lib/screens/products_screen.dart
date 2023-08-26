import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductsScreen extends StatefulWidget {
  static const String routeName = '/products';

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final height = Get.height;

  final width = Get.width;

  // bool _enabled = false;

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
                  mainAxisSpacing: width * 0.02,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    final productId = snapshot.data!.docs[index].reference.id;

                    return ProductCard(
                      productId: productId,
                      // product: snapshot.data!.docs[index].data(),
                      isAll: true,
                      id: snapshot.data!.docs[index].data()['id'],
                      isFavourite:
                          snapshot.data!.docs[index].data()['isFavourite'],
                    );
                  }

                  return CircularProgressIndicator();
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
