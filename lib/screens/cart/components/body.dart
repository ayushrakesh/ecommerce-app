import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/Cart.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final height = Get.height;
  final width = Get.width;

  void updateCartStatus(String id) async {
    var data = await FirebaseFirestore.instance
        .collection('products')
        .where('id', isEqualTo: id)
        .get();

    var docs = data.docs;

    for (var doc in docs) {
      await doc.reference.update({
        'is-in-basket': false,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  // key: Key(snapshot.data!.docs[index]['id']),
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    // await snapshot.data!.docs[index].reference.update({
                    //   'is-in-basket': false,
                    // });
                    await snapshot.data!.docs[index].reference.delete();
                    updateCartStatus(snapshot.data!.docs[index]['id']);
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: CartCard(cartItem: snapshot.data!.docs[index]),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
      ),
    );
  }
}
