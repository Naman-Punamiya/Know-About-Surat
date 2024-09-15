import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:know_about_surat/Pages/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage()
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Image(image: AssetImage('assets/food-stand.png')),
            const SizedBox(height: 25,),
            Text("One App For Your Food Needs And Place To Explore",style: GoogleFonts.quicksand(fontSize: 24,fontWeight: FontWeight.bold, letterSpacing: 1.25),textAlign: TextAlign.center,)
            // Text("One App For Your Food Needs And Place To Explore",style: GoogleFonts.lato(fontSize: 24,fontWeight: FontWeight.bold, letterSpacing: 1.25),)
            // Text("One App For Your Food Needs And Place To Explore",style: GoogleFonts.raleway(fontSize: 24,fontWeight: FontWeight.bold, letterSpacing: 1.25),)
          ]),
        ),
      ),
    );
  }
}
