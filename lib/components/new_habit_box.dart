import 'package:flutter/material.dart';
import 'package:habittrackerapp/constants/color_palette.dart';

class CreateNewHabitBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const CreateNewHabitBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.format_list_bulleted_add,
            size: 36,
          ),

          const SizedBox(
            height: 10,
          ),

          // Title of the box
          const Text(
            "Create a new habit",
            style: TextStyle(
              color: primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // Texfield for the name of your habit
          TextField(
            controller: controller,
            style: const TextStyle(color: Color.fromARGB(255, 110, 3, 3)),
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
              fillColor: textFieldBackgroundColor,
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(color: hintTextFieldColor),
            ),
          ),
        ],
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
