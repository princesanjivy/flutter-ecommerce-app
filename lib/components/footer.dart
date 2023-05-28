import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/helpers/change_screen.dart';
import 'package:ecom_app/pages/about.dart';
import 'package:ecom_app/pages/contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appName,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pages",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  VerticalSpacer(16),
                  InkWell(
                    onTap: (){
                      changeScreen(context, AboutPage());
                    },
                    child: Text(
                      "About",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      changeScreen(context, ContactPage());
                    },
                    child: Text(
                      "Contact",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'smith@example.com',
                      query: encodeQueryParameters(<String, String>{
                        'subject': 'Example Subject & Symbols are allowed!',
                      }),
                    );

                    launchUrl(emailLaunchUri);
                  }, icon: Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),),
                  HorizontalSpacer(12),
                  IconButton(
                    onPressed: () {
                      launchUrl(Uri.parse("https://facebook.com"));
                    },
                    icon: Icon(
                      Icons.facebook_outlined,
                      color: Colors.white,
                    ),
                  ),
                  HorizontalSpacer(12),
                  IconButton(
                    onPressed: () {
                      launchUrl(Uri.parse("https://instagram.com"));
                    },
                    icon: Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "© ${appName} 2023",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
