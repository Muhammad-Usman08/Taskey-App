import 'package:get/get.dart';

class TodayTaskViewModel extends GetxController {
  var selectedDay = (0).obs;

  void toggleSelection(int index) {
    if (selectedDay.value == index) {
      selectedDay.value = 0;
    } else {
      selectedDay.value = index;
    }
  }

  var daysOfWeek = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'].obs;

  String getDay(int index) {
    return daysOfWeek[index % daysOfWeek.length];
  }
}
