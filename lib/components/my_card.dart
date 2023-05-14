import 'package:ecom_app/components/my_button.dart';
import 'package:flutter/material.dart';

class MyItemCard extends StatelessWidget {
  const MyItemCard({Key? key}) : super(key: key);

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
              "https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=394&q=80",
              height: 100,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Column(
                children: [
                  Text("Watch"),
                  Text("\$ 500"),
                ],
              ),
              Icon(Icons.favorite),
            ],
          ),
          MyButton(
            text: "Add to cart",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
