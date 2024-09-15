import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final textcontroller;
  final String hintText;
  final bool obsecureText;

  const MyTextField({super.key,required this.textcontroller, required this.hintText, required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: textcontroller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2.0)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0)),
          fillColor: Colors.green,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
