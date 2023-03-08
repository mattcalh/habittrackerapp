import 'package:flutter/material.dart';
import 'package:habittrackerapp/components/month_summary.dart';
import 'package:habittrackerapp/constants/color_palette.dart';
import 'package:habittrackerapp/data/habit_database.dart';
import 'package:habittrackerapp/services/auth/auth_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    // If no data, this is the 1st time the app is opening
    // then create default data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }

    // If there is already data, then load data
    else {
      db.loadData();
    }

    // Update the Database
    db.updateDatabase();

    super.initState();
  }

  // Checkbox is tapped
  void checkBoxTapped(bool? value, int index) {
    setState(
      () {
        db.todayHabitList[index][1] = value;
      },
    );
    db.updateDatabase();
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
      db.todayHabitList.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
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
          hintText: db.todayHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // Save the new name for an existing habit
  void saveExistingHabit(int index) {
    setState(() {
      db.todayHabitList[index][0] = _newHabitNameController.text;
      _newHabitNameController.clear();
      Navigator.of(context).pop();
    });
    db.updateDatabase();
  }

  // Delete an existing habit
  void deleteHabit(int index) {
    setState(() {
      db.todayHabitList.removeAt(index);
    });
    db.updateDatabase();
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
        body: ListView(
          children: [
            // Heat map of monthly summary
            MonthlySummary(
              datasets: db.heatMapDataSet,
              startDate: _myBox.get("START_DATE"),
            ),

            // List of the habits
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todayHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitName: db.todayHabitList[index][0],
                  habitCompleted: db.todayHabitList[index][1],
                  onChanged: (value) => checkBoxTapped(value, index),
                  settingsTapped: (context) => openHabitSettings(index),
                  deleteTapped: (context) => deleteHabit(index),
                );
              },
            ),
          ],
        ));
  }
}
