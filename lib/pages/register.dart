import 'package:ecom_app/components/footer.dart';
import 'package:ecom_app/components/my_button.dart';
import 'package:ecom_app/components/my_spacer.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/helpers/change_screen.dart';
import 'package:ecom_app/pages/home.dart';
import 'package:ecom_app/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
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
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            VerticalSpacer(12),
            SizedBox(
              width: 250,
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
            showLoading?CircularProgressIndicator(
              color: primaryColor,
            ):MyButton(
              text: "Submit",
              onPressed: () async {
                showLoading = true;
                setState(() {});

                UserCredential userObj =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );

                userObj.user!.updateDisplayName(nameController.text!);

                showLoading = false;
                setState(() {});

                emailController.clear();
                passwordController.clear();
                nameController.clear();

                // Navigator.pop(context);
                // changeScreenWithReplacement(context, HomePage());
              },
            ),
            InkWell(
              onTap: () {
                changeScreen(
                  context,
                  LoginPage(),
                );
              },
              child: Text(
                "Already an user? Sign In",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
