import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habittrackerapp/constants/color_palette.dart';
import 'package:habittrackerapp/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: textFieldBackgroundColor,
        textColor: Color.fromARGB(255, 83, 81, 80),
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(20, 255, 126, 126),
          2: Color.fromARGB(40, 255, 126, 126),
          3: Color.fromARGB(60, 255, 126, 126),
          4: Color.fromARGB(80, 255, 126, 126),
          5: Color.fromARGB(100, 255, 126, 126),
          6: Color.fromARGB(120, 255, 126, 126),
          7: Color.fromARGB(150, 255, 126, 126),
          8: Color.fromARGB(180, 255, 126, 126),
          9: Color.fromARGB(220, 255, 126, 126),
          10: Color.fromARGB(255, 253, 126, 126),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
