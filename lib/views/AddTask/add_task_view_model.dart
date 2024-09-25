import 'package:get/get.dart';

class AddTaskViewModel extends GetxController {
  var selectedOption = 'Task'.obs;
  var selectedBoard = 'Urgent'.obs;
    var typeTask = 'Private'.obs;


  var teamMembers = <String>[].obs;

  void updateOption(String? newValue) {
    if (newValue != null) {
      selectedOption.value = newValue;
    }
  }

  void addTeamMember(String member) {
    if (!teamMembers.contains(member)) {
      teamMembers.add(member);
    }
  }
   void updateBoard(String? newBoard) {
    if (newBoard != null) {
      selectedBoard.value = newBoard;
    }
  }
   void updateType(String? type) {
    if (type != null) {
      typeTask.value = type;
    }
  }

  List<String> users = [
    'Usman',
    'Asher',
    'Sheryar',
    'Jeny',
    'Avishek',
    'Jafar',
    'Mitch',
  ];

  List<String> board = [
    'Urgent',
    'Running',
    'ongoing',
  ];

    List<String> type = [
    'Private',
    'Public',
    'Secret',
  ];
}
