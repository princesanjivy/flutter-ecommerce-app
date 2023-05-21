import 'package:ecom_app/components/footer.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/helpers/change_screen.dart';
import 'package:ecom_app/pages/cart.dart';
import 'package:flutter/material.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({
    Key? key,
    required this.mainImageUrl,
    required this.images,
    required this.description,
    required this.itemAmount,
    required this.itemName,
  }) : super(key: key);
  final String mainImageUrl;
  final List images;
  final String description;
  final double itemAmount;
  final String itemName;

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
                      widget.mainImageUrl,
                      height: width / 3,
                      width: width / 6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  VerticalSpacer(12),
                  Row(
                    children: [
                      for (int i = 0; i < widget.images.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              widget.images[i],
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
                        widget.itemName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
                      ),
                      HorizontalSpacer(150),
                      Icon(
                        Icons.favorite_border,
                        size: 32,
                      ),
                    ],
                  ),
                  VerticalSpacer(12),
                  SizedBox(
                    width: 200,
                    child: Text(widget.description),
                  ),
                  VerticalSpacer(24),
                  Text(
                    "\$ ${widget.itemAmount}",
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
