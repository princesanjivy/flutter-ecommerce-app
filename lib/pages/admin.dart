import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/helpers/change_screen.dart';
import 'package:ecom_app/pages/inventory.dart';
import 'package:ecom_app/pages/orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin " + appName),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                changeScreen(context, InventoryPage());
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 150,
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Inventory",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            HorizontalSpacer(32),
            InkWell(
              onTap: () {
                changeScreen(context, OrdersPage());
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 150,
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "View Orders",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
