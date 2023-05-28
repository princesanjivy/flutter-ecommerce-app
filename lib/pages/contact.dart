import 'package:ecom_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: MarkdownWidget(
            data: "For more information contact: admin@mail.com",
            shrinkWrap: false,
          ),
        ),
      ),
    );
  }
}
