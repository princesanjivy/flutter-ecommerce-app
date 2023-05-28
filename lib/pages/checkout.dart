import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/footer.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/helpers/change_screen.dart';
import 'package:ecom_app/models/item.dart';
import 'package:ecom_app/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
    required this.items,
    required this.page,
  }) : super(key: key);
  final List<Item> items;
  final int page;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  int stepperIndex = 0;
  double totalAmount = 0.0;

  bool isCreditCard = false, isDebitCard = false, isCashOnDel = false;

  getTotalAmount() {
    widget.items.forEach((item) {
      totalAmount += double.parse(item.itemAmount) * item.quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.items.length; i++)
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  widget.items[i].imageUrl,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(widget.items[i].itemName),
                            Text("Amount: \$ ${widget.items[i].itemAmount}"),
                            Text("Qty: ${widget.items[i].quantity}"),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Theme(
                data: ThemeData(
                  textTheme: GoogleFonts.kanitTextTheme(),
                  canvasColor: primaryColor,
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: primaryColor,
                        // background: Colors.red,
                        secondary: primaryColor,
                      ),
                ),
                child: Stepper(
                  steps: [
                    Step(
                      isActive: stepperIndex == 0,
                      title: Text("Billing Address"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          VerticalSpacer(12),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                label: Text("Name"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          VerticalSpacer(12),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: addressController,
                              decoration: InputDecoration(
                                label: Text("Shipping address"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          VerticalSpacer(12),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: phoneNoController,
                              decoration: InputDecoration(
                                label: Text("Phone number"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          VerticalSpacer(12),
                        ],
                      ),
                    ),
                    Step(
                      isActive: stepperIndex == 1,
                      title: Text("Payment"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isCreditCard,
                                onChanged: (value) {
                                  isCreditCard = !isCreditCard;
                                  setState(() {});
                                },
                              ),
                              Text("Credit Card"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isDebitCard,
                                onChanged: (value) {
                                  isDebitCard = !isDebitCard!;
                                  setState(() {});
                                },
                              ),
                              Text("Debit Card"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isCashOnDel,
                                onChanged: (value) {
                                  isCashOnDel = !isCashOnDel!;
                                  setState(() {});
                                },
                              ),
                              Text("Cash On  Delivery"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Step(
                      isActive: stepperIndex == 2,
                      title: Text("Order Summary"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${nameController.text}"),
                          Text("Address: ${addressController.text}"),
                          Text("Phone Number: ${phoneNoController.text}"),
                          Text("Total item: ${widget.items.length}"),
                          for (int i = 0; i < widget.items.length; i++)
                            Text(
                                "Item ${i + 1}: ${widget.items[i].itemName}; amount: ${widget.items[i].itemAmount}; quantity: ${widget.items[i].quantity}"),
                          Text("Total Amount: ${totalAmount}"),
                        ],
                      ),
                    ),
                  ],
                  currentStep: stepperIndex,
                  onStepContinue: () async {
                    if (stepperIndex == 0) {
                      if (nameController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          phoneNoController.text.isNotEmpty) {
                        stepperIndex = 1;
                        setState(() {});
                      }
                    } else if (stepperIndex == 1) {
                      if (isCreditCard != false ||
                          isDebitCard != false ||
                          isCashOnDel != false) {
                        stepperIndex = 2;
                        getTotalAmount();
                        setState(() {});
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Your Order has been placed"),
                        ),
                      );
                      Map itemQuant = {};
                      for(int index=0; index<widget.items.length; index++){
                        DocumentSnapshot i = await FirebaseFirestore.instance
                            .collection("inventory")
                            .doc(widget.items[index].itemId)
                            .get();

                        await FirebaseFirestore.instance
                            .collection("inventory")
                            .doc(widget.items[index].itemId)
                            .update({
                          "quantity": i.get("quantity") - widget.items[index].quantity
                        });

                        itemQuant[widget.items[index].itemId] = widget.items[index].quantity;
                      }

                      DocumentReference orders = await FirebaseFirestore
                          .instance
                          .collection("orders")
                          .add(
                        {
                          "userId": FirebaseAuth.instance.currentUser!.uid,
                          "inventory": itemQuant,
                          "address": addressController.text,
                          "phoneNumber": phoneNoController.text,
                          "name": nameController.text,
                          "paymentType": isCreditCard
                              ? 1
                              : isDebitCard
                                  ? 2
                                  : isCashOnDel
                                      ? 3
                                      : 0,
                          "status": "in-progress",
                          "totalAmount": totalAmount,
                        },
                      );

                      if (widget.page == 2) {
                        QuerySnapshot cart = await FirebaseFirestore.instance
                            .collection("cart")
                            .where("user-id",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .get();

                        for (int i = 0; i < cart.size; i++) {
                          await FirebaseFirestore.instance
                              .collection("cart")
                              .doc(cart.docs[i].id)
                              .delete();
                        }
                      }

                      // send e-mail
                      // MailgunClient client = MailgunClient(
                      //   "sandbox3bb3c37bd6ed41ada545edc43e29e8ea.mailgun.org",
                      //   "53cc1920958c629c60d8ce2ec2ee95d9-70c38fed-19ce17cb",
                      // );
                      //
                      // var messageClient = client.message;
                      // var params = MessageParams(
                      //   "Demo Project no-reply@sandbox3bb3c37bd6ed41ada545edc43e29e8ea.mailgun.org",
                      //   [FirebaseAuth.instance.currentUser!.email!],
                      //   'Your order confirmation for ${orders.id}',
                      //   MessageContent.text('Items details to be displayed here'),
                      // );
                      // var response = await messageClient.send(params);
                      //
                      // print(response.statusCode);
                      // await response.body!.then((value) => print(value));

                      // var response = await http.post(
                      //   Uri.https(
                      //     "api.mailgun.net",
                      //     "/v3/sandbox3bb3c37bd6ed41ada545edc43e29e8ea.mailgun.org/messages",
                      //   ),
                      //   headers: {
                      //     "api":
                      //         "53cc1920958c629c60d8ce2ec2ee95d9-70c38fed-19ce17cb",
                      //     "Access-Control-Allow-Origin": "*",
                      //   },
                      //   body: jsonEncode(
                      //     {
                      //       "from":
                      //           "Excited User user@sandbox3bb3c37bd6ed41ada545edc43e29e8ea.mailgun.org",
                      //       "to": [FirebaseAuth.instance.currentUser!.email],
                      //       "subject": "Your order confirmation for ${orders.id}",
                      //       "text": "Items details to be displayed here"
                      //     },
                      //   ),
                      // );
                      //
                      // print(response.statusCode);
                      // print(response.body);

                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return InventoryPage();
                      //     },
                      //   ),
                      // );

                      Navigator.pop(context);
                      Navigator.pop(context);
                      changeScreenWithReplacement(context, HomePage());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
