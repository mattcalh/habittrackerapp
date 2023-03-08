import 'package:habittrackerapp/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Reference the name of our database opened for the app
final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List todayHabitList = [];

  // Create initial default data
  void createDefaultData() {
    todayHabitList = [
      ["Run", false],
      ["Meditate", false]
    ];

    _myBox.put("START_DATE", todayDateFormatted());
  }

  // Load data if it already exists
  void loadData() {
    // If new day, get habit list from database
    if (_myBox.get(todayDateFormatted()) == null) {
      todayHabitList = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < todayHabitList.length; i++) {
        todayHabitList[i][1] = false;
      }
    }
    // If not new day, load today list
    else {
      todayHabitList = _myBox.get(todayDateFormatted());
    }
  }

  // update database
  void updateDatabase() {
    // Update today entry
    _myBox.put(todayDateFormatted(), todayHabitList);

    // Update habits if modified
    _myBox.put("CURRENT_HABIT_LIST", todayHabitList);
  }
}
