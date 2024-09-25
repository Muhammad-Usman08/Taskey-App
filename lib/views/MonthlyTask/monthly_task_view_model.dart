import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskey_app/views/MonthlyTask/MonthlyComponents/daily_task_card.dart';

class MonthlyTaskViewModel extends GetxController {
  var selectedDate = DateTime.now().obs; // Observable for selected date
  var selectedDayIndex = (-1).obs; // -1 indicates no selection

  String getDay(int index) {
    final date = DateTime.now().add(Duration(days: index));
    return DateFormat('EEE').format(date); // Short day format
  }

  void toggleSelection(int index) {
    // If the same day is selected, deselect it
    if (selectedDayIndex.value == index) {
      selectedDayIndex.value = -1; // Deselect
    } else {
      selectedDayIndex.value = index; // Select new day
    }
  }

  List<String> getDaysInMonth(DateTime date) {
    List<String> days = [];
    for (int i = 1; i <= DateTime(date.year, date.month + 1, 0).day; i++) {
      days.add(getDay(i - 1));
    }
    return days;
  }
}
