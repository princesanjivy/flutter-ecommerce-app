import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/constants.dart';
import 'package:ecom_app/pages/admin.dart';
import 'package:ecom_app/pages/cart.dart';
import 'package:ecom_app/pages/home.dart';
import 'package:ecom_app/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDUK_opszFZSNgzr5Rp6GtDt7mkpmO89Lg",
      appId: "1:343660851275:web:7040ef8287fd2f9a7c1dce",
      messagingSenderId: "343660851275",
      projectId: "fir-project-426e2",
    ),
  );

  runApp(
    App(),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(),
        canvasColor: Colors.white,
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          // background: Colors.red,
          secondary: primaryColor,
        ),
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, user) {
            if (user.hasData) {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("admin")
                    .where("email", isEqualTo: user.data!.email)
                    .snapshots(),
                builder: (context, adminSnapshot) {
                  if (adminSnapshot.hasData) {
                    if (adminSnapshot.data!.size == 1) {
                      // TODO
                      return AdminPage();
                    } else {
                      return HomePage();
                    }
                  }
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  );
                },
              );
            }
          return RegisterPage();
        }
      ),
    );
  }
}
