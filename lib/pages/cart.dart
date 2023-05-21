import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/footer.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.orange,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("cart")
              .where("user-id",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, d) {
            if (!d.hasData) {
              return CircularProgressIndicator(
                color: primaryColor,
              );
            }
            return Stack(
              alignment:   (d.data!.size == 0)
                  ? Alignment.topCenter: Alignment.bottomRight,
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (d.data!.size == 0)
                              ? "No items in cart!"
                              : "Your cart items",
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                        VerticalSpacer(32),
                        for (int i = 0; i < d.data!.size; i++)
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("inventory")
                                    .doc(d.data!.docs[i].get("inventory-id"))
                                    .snapshots(),
                                builder: (context, inventory) {
                                  if (!inventory.hasData) {
                                    return CircularProgressIndicator(
                                      color: primaryColor,
                                    );
                                  }
                                  Map item = inventory.data!.data() as Map;
                                  return MyCard(
                                    itemName: item["name"],
                                    imageUrl: item["imageUrl"][0],
                                    itemAmount: item["amount"],
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("cart")
                                          .doc(d.data!.docs[i].id)
                                          .delete();
                                    },
                                  );
                                }),
                          ),
                      ],
                    ),
                  ),
                ),
                (d.data!.size == 0)
                    ? Container():  Padding(
                  padding: const EdgeInsets.all(25),
                  child: MyButton(text: "Checkout", onPressed: () {}),
                ),
              ],
            );
          }),
      bottomNavigationBar: Footer(),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
    required this.imageUrl,
    required this.itemName,
    required this.itemAmount,
    required this.onPressed,
  }) : super(key: key);

  final String imageUrl;
  final String itemName;
  final double itemAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 80 + 2,
          width: width / 3 + 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        Container(
          height: 80,
          width: width / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                itemName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              // Text(
              //   "Qty: $qty",
              // ),
              Text(
                "\$ ${itemAmount}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.delete,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
