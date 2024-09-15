import 'package:flutter/material.dart';
import 'package:know_about_surat/Pages/login.dart';
import 'package:know_about_surat/Pages/register_page.dart';

class LoginorregisterPage extends StatefulWidget {
  const LoginorregisterPage({super.key});

  @override
  State<LoginorregisterPage> createState() => _LoginorregisterPageState();
}

class _LoginorregisterPageState extends State<LoginorregisterPage> {
  bool showLogin = true;

  void togglePages(){
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if(showLogin){
    //   return LoginPage(onTap: togglePages,);
    // }else{
    //   return RegisterPage(onTap: togglePages,);
    // }
    return Scaffold(
      body: showLogin
          ? LoginPage(onTap: togglePages)
          : RegisterPage(onTap: togglePages),
    );
  }
}