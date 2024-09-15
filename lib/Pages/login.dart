 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:know_about_surat/models/mybutton.dart';
import 'package:know_about_surat/models/textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, password: passwordController.text);
      Navigator.pushReplacementNamed(context, '/auth');
  } on FirebaseAuthException catch (e) {
    errorMessage(context, e.code);
  } catch (e) {
    errorMessage(context ,"Unknown Error Occured");
  }
}

  void errorMessage(BuildContext context, String text) {
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text(text),actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the error dialog
              },
              child: const Text('OK'),
            ),
          ],);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Image(
                  image: AssetImage("assets/groceries.png"),
                  height: 175,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Welcome back You've been missed!",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  textcontroller: emailController,
                  hintText: 'Email',
                  obsecureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  textcontroller: passwordController,
                  hintText: 'Password',
                  obsecureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget Password?",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register Now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
