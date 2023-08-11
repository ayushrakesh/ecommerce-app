import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final height = Get.height;
  final width = Get.width;

  final Razorpay _razorpay = Razorpay();

  final amountController = TextEditingController();

  num amount = 0;
  var cartDocs;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    handlePaymentSuccess();
  }

  void handlePaymentSuccess() async {
    final cartData = await FirebaseFirestore.instance.collection('cart').get();
    final cartDocs = cartData.docs.map((e) => e.data()).toList();

    num totalAmount = 0;
    num numOfItems = 0;
    var products = [];

    cartDocs.forEach((element) {
      totalAmount = totalAmount + element['price'] * element['quantity'];
      numOfItems = numOfItems + element['quantity'];

      products.add({
        'product-name': element['name'],
        'product-image': element['image'],
        'product-price': element['price'],
        'product-quantity': element['quantity'],
      });
    });

    await FirebaseFirestore.instance.collection('orders').add({
      'created-at': DateTime.now().toIso8601String(),
      'products': products,
      'total-amount': totalAmount,
      'number-of-items': numOfItems,
    });

    await FirebaseFirestore.instance.collection("cart").get().then((res) async {
      for (var doc in res.docs) {
        await doc.reference.delete();
      }
    });

    final productsData = await FirebaseFirestore.instance
        .collection('products')
        .where('is-in-basket', isEqualTo: true)
        .get();
    for (var doc in productsData.docs) {
      await doc.reference.update({
        'is-in-basket': false,
      });
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final argsList = ModalRoute.of(context)!.settings.arguments as List;
    final payAmount = argsList[0] as num;

    print(cartDocs);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w300,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          top: height * 0.04,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Total Amount : ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.currency_rupee,
                      size: 20,
                    ),
                    Text(
                      payAmount.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gap(height * 0.05),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    Text('You are paying'),
                    Gap(height * 0.01),
                    TextField(
                      controller: amountController,
                      onChanged: (value) {
                        setState(() {
                          amount = num.parse(value);
                        });
                      },
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: width,
              child: ElevatedButton(
                onPressed: amountController.text == payAmount.toString()
                    ? () {
                        FocusScope.of(context).unfocus();

                        var options = {
                          'key': dotenv.env['RAZORPAY_KEY'],
                          'amount':
                              amount * 100, //in the smallest currency sub-unit.
                          'name': 'text copor.',
                          // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                          'description': 'Payment to purchase a product ',
                          'timeout': 300, // in seconds
                          'prefill': {
                            'contact': '7000427287',
                            'email': 'ayushrakesh35711artlover@gmail.com'
                          },
                        };

                        _razorpay.open(options);
                      }
                    : null,
                child: Text('Pay'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
