import 'package:flutter/material.dart';
import 'package:habittrackerapp/constants/color_palette.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;

  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(18),
        color: textFieldBackgroundColor,
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
