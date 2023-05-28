import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Map<String, dynamic> inventoryData = {};
  bool showLoading = false;

  @override
  void initState() {
    super.initState();

    getInventoryData();
  }

  getInventoryData() async {
    showLoading = true;
    setState(() {});
    QuerySnapshot inventory =
        await FirebaseFirestore.instance.collection("inventory").get();

    for (int i = 0; i < inventory.size; i++) {
      inventoryData[inventory.docs[i].id] = inventory.docs[i].data();
    }
    showLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: showLoading
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("orders").snapshots(),
              builder: (context, orders) {
                if (!orders.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                if (orders.data!.size == 0) {
                  return Center(child: Text("No orders"));
                }

                return ListView.builder(
                  itemCount: orders.data!.size,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        Map<String, dynamic> items = orders.data!.docs[index]
                            .get("inventory") as Map<String, dynamic>;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                "Order id: ${orders.data!.docs[index].id}"),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Customer name: ${orders.data!.docs[index].get("name")}"),
                                  Text(
                                      "Address: ${orders.data!.docs[index].get("address")}"),
                                  Text(
                                      "Phone number: ${orders.data!.docs[index].get("phoneNumber")}"),
                                  getItemsData(items),
                                  VerticalSpacer(32),
                                  Text(
                                      "Total amount: \$${orders.data!.docs[index].get("totalAmount")}"),
                                ],
                              ),
                            ),
                            actions: [
                              MyButton(
                                text: "Ok",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: primaryColor.withOpacity(0.5),
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text("Order id: ${orders.data!.docs[index].id}"),
                      subtitle: Text(
                          "Total Amount: \$${orders.data!.docs[index].get("totalAmount")}"),
                    );
                  },
                );
              }),
    );
  }

  Widget getItemsData(Map<String, dynamic> items) {
    List<Widget> t = [];

    items.forEach((key, value) {
      t.add(Text(
          "Item name: ${inventoryData[key]["name"]}; Price: ${inventoryData[key]["amount"]}; Quantity: ${value}"));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: t,
    );
  }
}
