import 'package:flutter/material.dart';
import 'package:know_about_surat/Pages/auth_page.dart';
import 'package:know_about_surat/Pages/home_page.dart';
import 'package:know_about_surat/Pages/intro.dart';
import 'package:know_about_surat/Pages/loginOrRegister.dart';
import 'package:know_about_surat/Pages/splash.dart';
import 'package:know_about_surat/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final first = prefs.getBool("First") ?? false;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MyApp(
      first: first,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool first;
  const MyApp({super.key, this.first = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/homepage': (context) => const HomePage(),
        '/login' : (context) => const LoginorregisterPage(),
        '/auth' : (context) => const AuthPage(),
      },
    );
  }
}
