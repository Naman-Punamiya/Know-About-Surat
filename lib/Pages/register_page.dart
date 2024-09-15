import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:know_about_surat/models/mybutton.dart';
import 'package:know_about_surat/models/textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.pushReplacementNamed(context, '/auth');
      }else{
        errorMessage(context,"Password Doesn't Match");
      }
    } on FirebaseAuthException catch (e) {
      errorMessage(context, e.code);
    }
  }

  void errorMessage(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
          );
        });
  }

  // void signUserOut() {
  //   FirebaseAuth.instance.signOut();
  // }

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
                  height: 25,
                ),
                const Image(
                  image: AssetImage("assets/groceries.png"),
                  height: 175,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Let's Create an account for you!",
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
                MyTextField(
                  textcontroller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obsecureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now",
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