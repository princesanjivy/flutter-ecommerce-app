import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/footer.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/helpers/change_screen.dart';
import 'package:ecom_app/models/item.dart';
import 'package:ecom_app/pages/cart.dart';
import 'package:ecom_app/pages/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'checkout.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
        backgroundColor: primaryColor,
        elevation: 0,

      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("wishlist")
              .where("user-id",
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, d) {
            if (!d.hasData) {
              return CircularProgressIndicator(
                color: primaryColor,
              );
            }
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      (d.data!.size == 0)
                          ? "No items in cart!"
                          : "Your wishlist",
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
                              String userId = FirebaseAuth.instance.currentUser!.uid;
                              String itemId = d.data!.docs[i].id;
                              return InkWell(
                                onTap: (){
                                  changeScreen(
                                      context,
                                      ItemDetailsPage(
                                        itemName: item["name"],
                                        itemAmount: item["amount"],
                                        description: item["description"],
                                        images: item["imageUrl"],
                                        mainImageUrl: item["imageUrl"][0],
                                        userId: userId,
                                        itemId: itemId,
                                      ));
                                },
                                child: MyCard(
                                  itemName: item["name"],
                                  imageUrl: item["imageUrl"][0],
                                  itemAmount: item["amount"],
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection("wishlist")
                                        .doc(d.data!.docs[i].id)
                                        .delete();
                                  },
                                ),
                              );
                            }),
                      ),
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Footer(),
    );
  }
}
