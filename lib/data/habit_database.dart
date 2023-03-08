import 'package:habittrackerapp/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Reference the name of our database opened for the app
final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List todayHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

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

    // Calucalte complete percentages of habits each day
    calculateHabitPercentages();

    // Load Montly Summary Heat Map
    loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < todayHabitList.length; i++) {
      if (todayHabitList[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = todayHabitList.isEmpty
        ? '0.0'
        : (countCompleted / todayHabitList.length).toStringAsFixed(1);

    // Key =  "PERCENTAGE_SUMMARY_yyyymmdd"
    // value: string of 1dp number between 0-1 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_${todayDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
