import 'package:flutter/material.dart';
import 'package:habittrackerapp/constants/color_palette.dart';

class CreateNewHabitBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const CreateNewHabitBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Color.fromARGB(255, 110, 3, 3)),
        decoration: const InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: primaryColor,
          child: const Text(
            "Save",
            style: TextStyle(color: backgroundColor),
          ),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: primaryColor,
          child: const Text(
            "Cancel",
            style: TextStyle(color: backgroundColor),
          ),
        ),
      ],
    );
  }
}
