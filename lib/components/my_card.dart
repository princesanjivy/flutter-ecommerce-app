import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:flutter/material.dart';

class MyItemCard extends StatefulWidget {
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
  State<MyItemCard> createState() => _MyItemCardState();
}

class _MyItemCardState extends State<MyItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150,
      // height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primaryColor.withOpacity(0.5),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.imageUrl,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          VerticalSpacer(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.itemName,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text("\$ ${widget.itemAmount}"),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("wishlist")
                      .where("user-id", isEqualTo: widget.userId)
                      .where("inventory-id", isEqualTo: widget.itemId)
                      .snapshots(),
                  builder: (context, wishlist) {
                    if (!wishlist.hasData) {
                      return CircularProgressIndicator(color: primaryColor,);
                    }
                    return IconButton(
                      onPressed: () async {
                        if (wishlist.data!.size == 0) {
                          FirebaseFirestore.instance
                              .collection("wishlist")
                              .add({
                            "inventory-id": widget.itemId,
                            "user-id": widget.userId,
                          });
                        } else {
                          FirebaseFirestore.instance
                              .collection("wishlist")
                              .doc(wishlist.data!.docs.first.id)
                              .delete();
                        }
                      },
                      icon: Icon(
                        (wishlist.data!.size == 0)?Icons.favorite_border_rounded:Icons.favorite_rounded,
                        color: (wishlist.data!.size == 0)?Colors.black:primaryColor,
                      ),
                    );
                  }),
            ],
          ),
          VerticalSpacer(16),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("cart")
                  .where("user-id", isEqualTo: widget.userId)
                  .where("inventory-id", isEqualTo: widget.itemId)
                  .snapshots(),
              builder: (context, cartSS) {
                if (!cartSS.hasData) {
                  return CircularProgressIndicator(color: primaryColor,);
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
                            "user-id": widget.userId,
                            "inventory-id": widget.itemId,
                          });
                        },
                      );
              }),
        ],
      ),
    );
  }
}
