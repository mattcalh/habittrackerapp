import 'package:flutter/material.dart';
import 'package:habittrackerapp/constants/color_palette.dart';
import 'package:habittrackerapp/services/auth/auth_service.dart';

import '../components/habit_tile.dart';
import '../constants/routes.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool habitCompleted = false;

  void checkBoxTapped(bool? value) {
    setState(() {
      habitCompleted = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        children: [
          HabitTile(
            habitName: "Meditation",
            habitCompleted: habitCompleted,
            onChanged: (value) => checkBoxTapped(value),
          ),
        ],
      ),
    );
  }
}
