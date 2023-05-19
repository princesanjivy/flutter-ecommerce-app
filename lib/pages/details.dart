import 'package:ecom_app/components/footer.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/helpers/change_screen.dart';
import 'package:ecom_app/pages/cart.dart';
import 'package:flutter/material.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({Key? key}) : super(key: key);

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  TextEditingController qtyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    qtyController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              changeScreen(context, CartPage());
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Image
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=394&q=80",
                      height: width / 3,
                      width: width / 6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  VerticalSpacer(12),
                  Row(
                    children: [
                      for (int i = 0; i < 3; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              "https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=394&q=80",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),

              /// description
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Watch",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
                      ),
                      HorizontalSpacer(150),
                      Icon(Icons.favorite_border, size: 32,),
                    ],
                  ),
                  VerticalSpacer(12),
                  SizedBox(
                    width: 200,
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Infaucibus mollis tristique Nunc congue turpis."),
                  ),
                  VerticalSpacer(24),
                  Text(
                    "\$ 200",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  VerticalSpacer(12),
                  Row(
                    children: [
                      Text(
                        "Qty",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      HorizontalSpacer(12),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          controller: qtyController,
                          decoration: InputDecoration(
                            label: Text("Qty"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  VerticalSpacer(12),
                  MyButton(
                    text: "Buy Now",
                    onPressed: () {},
                  ),
                  VerticalSpacer(8),
                  MyButton(
                    text: "Add to Cart",
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
