import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/Cart.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  final Stream snapshots =
      FirebaseFirestore.instance.collection('cart').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Column(
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                num items = 0;
                var docs = snapshot.data!.docs.forEach(
                  (element) {
                    items = items + (element.data()['quantity']);
                  },
                );
                return Text(
                  "${items} items",
                  style: Theme.of(context).textTheme.caption,
                );
              }
              return SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              );
            },
            stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          )
        ],
      ),
    );
  }
}
