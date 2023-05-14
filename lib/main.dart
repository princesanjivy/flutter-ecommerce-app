import 'package:ecom_app/pages/register.dart';
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
      ),
      home: RegisterPage(),
    );
  }
}
