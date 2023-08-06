import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import '../../products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Popular Products",
          press: () {
            Navigator.of(context).pushNamed(ProductsScreen.routeName);
          },
        ),
        Gap(height * 0.03),
        SizedBox(
          height: height * 0.4,
          width: double.infinity,
          child: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    print(snapshot.data!.docs);
                    return ProductCard(
                      product: snapshot.data!.docs[index].data(),
                    );
                  },
                  itemCount: 3,
                );
              }
              return CircularProgressIndicator();
            },
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
          ),
        )
      ],
    );
  }
}
