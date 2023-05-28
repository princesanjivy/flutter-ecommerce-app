import 'package:ecom_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About " + appName),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: MarkdownWidget(data: """# E-Commerce Demo App

This E-Commerce Demo App is an application developed using Flutter for Web and Firebase. It serves as a comprehensive learning resource for school graduates to understand the basics of Flutter development. The app showcases a simplified e-commerce platform with key features including user authentication, product browsing, cart management, checkout simulation, and wishlist functionality.

## Features

- **User Authentication**: Users can register and log in to the app, allowing them to access personalized features and maintain their own shopping carts and wishlists. Firebase Authentication is utilized to provide a secure and seamless authentication experience.

- **Product Browsing**: The app provides users with a user-friendly interface to browse a variety of product items. These items are displayed with relevant details, such as images, descriptions, and prices.

- **Cart Management**: Users can add desired products to their shopping carts. They have the ability to update the quantity of each item, remove items, and view the total cost of the items in their cart.

- **Checkout Simulation**: The app offers a checkout process, allowing users to proceed through the purchase flow without actual payment.

- **Item Details**: Users can view detailed information about each product item in a separate page. This includes additional images, specifications, and any other relevant information.

- **Wishlist**: Users can add items to their wishlist, allowing them to save products for future reference or potential purchase. This feature helps users keep track of desired items and make informed decisions during their shopping experience.

- **Admin**: The app includes a separate page specifically designed for admin users. Admins have the ability to add new products to the inventory, delete existing items, and view the order details. This feature empowers administrators to manage the app's product catalog and track customer orders.
To access the admin page, log in using the following credentials: Email: admin@mail.com, Password: testpass1234."""),
        ),
      ),
    );
  }
}
