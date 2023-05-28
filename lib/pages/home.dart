import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/footer.dart';
import 'package:ecom_app/components/my_card.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/helpers/change_screen.dart';
import 'package:ecom_app/pages/cart.dart';
import 'package:ecom_app/pages/details.dart';
import 'package:ecom_app/pages/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              changeScreen(context, WishlistPage());
            },
            icon: Icon(
              Icons.favorite_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              changeScreen(context, CartPage());
            },
            icon: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 1440,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("inventory")
                  .snapshots(),
              builder: (context, d) {
                if (!d.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if (d.data!.size == 0) {
                  return Center(child: Text("No items to show!"));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                    childAspectRatio: 3 / 4,
                  ),
                  padding: EdgeInsets.all(30),
                  itemCount: d.data!.size,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String userId = FirebaseAuth.instance.currentUser!.uid;
                    String itemId = d.data!.docs[index].id;
                    Map item = d.data!.docs[index].data() as Map;
                    return InkWell(
                      onTap: () {
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
                      child: MyItemCard(
                        imageUrl: item["imageUrl"][0],
                        itemAmount: item["amount"],
                        itemName: item["name"],
                        itemId: itemId,
                        userId: userId,
                      ),
                    );
                  },
                  // children: [
                  //   for (int i = 0; i < 10; i++)
                  //     InkWell(
                  //       onTap: () {
                  //         changeScreen(context, ItemDetailsPage());
                  //       },
                  //       child: MyItemCard(),
                  //     ),
                  // ],
                );
              }),
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
