import 'package:flutter/material.dart';
import 'package:habittrackerapp/constants/color_palette.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;
  final String textForButton;

  const LoginButton({
    super.key,
    required this.onTap,
    required this.textForButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            textForButton,
            style: const TextStyle(
                color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
