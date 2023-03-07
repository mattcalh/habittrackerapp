import 'package:flutter/material.dart';
import 'package:habittrackerapp/constants/color_palette.dart';

class LoginField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const LoginField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(14),
          ),
          fillColor: textFieldBackgroundColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: hintTextFieldColor),
        ),
      ),
    );
  }
}
