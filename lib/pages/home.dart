import 'package:ecom_app/components/footer.dart';
import 'package:ecom_app/components/my_card.dart';
import 'package:ecom_app/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName + " Home"),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.all(30),
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          shrinkWrap: true,
          childAspectRatio: 2,
          children: [
            for (int i = 0; i < 10; i++) MyItemCard(),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
