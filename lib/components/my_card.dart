import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:flutter/material.dart';

class MyItemCard extends StatelessWidget {
  const MyItemCard({
    Key? key,
    required this.imageUrl,
    required this.itemName,
    required this.itemAmount,
    required this.userId,
    required this.itemId,
  }) : super(key: key);

  final String imageUrl;
  final String itemName;
  final double itemAmount;
  final String userId;
  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.orange,
      ),
      padding: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemName),
                  Text("\$ ${itemAmount}"),
                ],
              ),
              Icon(Icons.favorite),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("cart")
                  .where("user-id", isEqualTo: userId)
                  .where("inventory-id", isEqualTo: itemId)
                  .snapshots(),
              builder: (context, cartSS) {
                if (!cartSS.hasData) {
                  return CircularProgressIndicator();
                }
                return cartSS.data!.size == 1
                    ? Text(
                        "Added to cart",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : MyButton(
                        text: "Add to cart",
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("cart")
                              .add({
                            "user-id": userId,
                            "inventory-id": itemId,
                          });
                        },
                      );
              }),
        ],
      ),
    );
  }
}
