import 'package:ecom_app/components/footer.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/helpers/change_screen.dart';
import 'package:ecom_app/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            VerticalSpacer(12),
            SizedBox(
              width: 250,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            VerticalSpacer(8),
            SizedBox(
              width: 250,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
              ),
            ),
            VerticalSpacer(8),
            showLoading
                ? CircularProgressIndicator(
                    color: primaryColor,
                  )
                : MyButton(
                    text: "Submit",
                    onPressed: () async {
                      bool changePage = false;
                      showLoading = true;
                      setState(() {});
                      try {
                        UserCredential user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        changePage = true;
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Error occured while Logging In")));
                      } finally {
                        showLoading = false;
                        setState(() {});

                        emailController.clear();
                        passwordController.clear();
                      }
                      if (changePage) Navigator.pop(context);

                      // changeScreenWithReplacement(context, HomePage());
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
