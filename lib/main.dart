import 'package:ecommerce_app/routes.dart';
import 'package:ecommerce_app/screens/home/home_screen.dart';
import 'package:ecommerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce_app/screens/splash/splash_screen.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce',
      theme: theme(),
      home: StreamBuilder<User?>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return SignInScreen();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
      // initialRoute: SplashScreen.routeName,
      // home: SplashScreen(),
      routes: routes,
    );
  }
}
