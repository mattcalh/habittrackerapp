import 'package:flutter/material.dart';
import 'package:habittrackerapp/constants/color_palette.dart';
import 'package:habittrackerapp/services/auth/auth_service.dart';

import '../components/habit_tile.dart';
import '../components/my_floating_button.dart';
import '../components/new_habit_box.dart';
import '../constants/routes.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // List of habits created
  List todayHabitList = [
    ['Meditation', false],
    ['Workout', false],
    ['Walk', false],
  ];

  // Checkbox is tapped
  void checkBoxTapped(bool? value, int index) {
    setState(
      () {
        todayHabitList[index][1] = value;
      },
    );
  }

  final _newHabitNameController = TextEditingController();

  // Create a new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateNewHabitBox(
          controller: _newHabitNameController,
          hintText: "Add new habit",
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // Svae the new habit
  void saveNewHabit() {
    setState(() {
      todayHabitList.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  // Cancel the action of editing/creating the habit
  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  // Modifiy an exiting habit
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CreateNewHabitBox(
          controller: _newHabitNameController,
          hintText: todayHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // Save the new name for an existing habit
  void saveExistingHabit(int index) {
    setState(() {
      todayHabitList[index][0] = _newHabitNameController.text;
      _newHabitNameController.clear();
      Navigator.of(context).pop();
    });
  }

  // Delete an existing habit
  void deleteHabit(int index) {
    setState(() {
      todayHabitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todayHabitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: todayHabitList[index][0],
            habitCompleted: todayHabitList[index][1],
            onChanged: (value) => checkBoxTapped(value, index),
            settingsTapped: (context) => openHabitSettings(index),
            deleteTapped: (context) => deleteHabit(index),
          );
        },
      ),
    );
  }
}
