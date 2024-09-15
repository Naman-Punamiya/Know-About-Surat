import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:know_about_surat/Pages/home_page.dart';
import 'package:know_about_surat/Pages/intro.dart';
import 'package:know_about_surat/Pages/loginOrRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late Future<bool> _hasSeenIntroFuture;

  @override
  void initState() {
    super.initState();
    _hasSeenIntroFuture = _getIntroStatus();
  }

  Future<bool> _getIntroStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasSeenIntro') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return FutureBuilder<bool>(
              future: _hasSeenIntroFuture,
              builder: (context, introSnapshot) {
                if (introSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (introSnapshot.hasData && introSnapshot.data == true) {
                  return const HomePage();
                } else {
                  return const IntroPage();
                }
              },
            );
          } else {
            return const LoginorregisterPage();
          }
        },
      ),
    );
  }
}
