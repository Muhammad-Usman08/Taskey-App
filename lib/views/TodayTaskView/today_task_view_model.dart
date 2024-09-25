import 'package:get/get.dart';

class TodayTaskViewModel extends GetxController {
  var selectedDay = 0.obs;

  TodayTaskViewModel() {
    _selectToday();
  }

  void _selectToday() {
    final todayIndex = DateTime.now().day - 1; // Adjust based on how you want the index
    selectedDay.value = todayIndex;
  }

  var daysOfWeek = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'].obs;

  String getDay(int index) {
    return daysOfWeek[index % daysOfWeek.length];
  }
}
