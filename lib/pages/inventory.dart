import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("inventory").snapshots(),
        builder: (context, inventory) {
          if (!inventory.hasData) {
            return CircularProgressIndicator(
              color: primaryColor,
            );
          }

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < inventory.data!.size; i++)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        TextEditingController amountController =
                            TextEditingController();
                        TextEditingController qtyController =
                            TextEditingController();

                        amountController.text =
                            inventory.data!.docs[i].get("amount").toString();
                        qtyController.text =
                            inventory.data!.docs[i].get("quantity").toString();

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Text(
                                "Edit item: ${inventory.data!.docs[i].get("name")}"),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: amountController,
                                    decoration: InputDecoration(
                                      label: Text("Amount"),
                                    ),
                                  ),
                                  VerticalSpacer(12),
                                  TextField(
                                    controller: qtyController,
                                    decoration: InputDecoration(
                                      label: Text("Quantity"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              MyButton(
                                text: "Update",
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("inventory")
                                      .doc(inventory.data!.docs[i].id)
                                      .update({
                                    "amount": double.parse(
                                      amountController.text.toString(),
                                    ),
                                    "quantity": int.parse(
                                      qtyController.text.toString(),
                                    ),
                                  });

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: MyCard(
                        itemName: inventory.data!.docs[i].get("name"),
                        imageUrl: inventory.data!.docs[i].get("imageUrl")[0],
                        itemAmount: inventory.data!.docs[i].get("amount"),
                        quantity: inventory.data!.docs[i].get("quantity"),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("inventory")
                              .doc(inventory.data!.docs[i].id)
                              .delete();
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController amountController = TextEditingController();
          TextEditingController qtyController = TextEditingController();
          TextEditingController nameController = TextEditingController();
          TextEditingController imageUrlController = TextEditingController();
          TextEditingController descController = TextEditingController();

          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(
              title: Text("New Item"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        label: Text("Name"),
                      ),
                    ),
                    VerticalSpacer(12),
                    TextField(
                      controller: descController,
                      decoration: InputDecoration(
                        label: Text("Description"),
                      ),
                    ),
                    VerticalSpacer(12),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        label: Text("Amount"),
                      ),
                    ),
                    VerticalSpacer(12),
                    TextField(
                      controller: qtyController,
                      decoration: InputDecoration(
                        label: Text("Quantity"),
                      ),
                    ),
                    VerticalSpacer(12),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: imageUrlController,
                        decoration: InputDecoration(
                          label: Text("Image"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                MyButton(
                  text: "Add",
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("inventory")
                        .add({
                      "amount": double.parse(
                        amountController.text.toString(),
                      ),
                      "quantity": int.parse(
                        qtyController.text.toString(),
                      ),
                      "name": nameController.text.toString(),
                      "description": descController.text.toString(),
                      "imageUrl": [
                        imageUrlController.text.toString(),
                        imageUrlController.text.toString(),
                        imageUrlController.text.toString(),
                        imageUrlController.text.toString(),
                      ],
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
        child: Text("Add"),
      ),
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
    required this.quantity,
  }) : super(key: key);

  final String imageUrl;
  final String itemName;
  final double itemAmount;
  final int quantity;
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
              Text(
                "Qty: ${quantity}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
