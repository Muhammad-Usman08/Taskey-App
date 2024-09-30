import 'package:cloud_firestore/cloud_firestore.dart';
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

class Task {
  final String taskName;
  final String date;
  final String desc;
  final String startTime;
  final String endTime;
  final String leaderId;
  final String logoUrl;
  final int targetProgress;
  final String teamName;
  final String type;
  final String workType;
  final List<Map<String, dynamic>> teamMembers;

  Task({
    required this.taskName,
    required this.date,
    required this.desc,
    required this.startTime,
    required this.endTime,
    required this.leaderId,
    required this.logoUrl,
    required this.targetProgress,
    required this.teamName,
    required this.type,
    required this.workType,
    required this.teamMembers,
  });

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Task(
      taskName: data['taskName'] ?? 'No Task Name',
      date: data['date'] ?? 'No Date',
      desc: data['desc'] ?? 'No Description',
      startTime: data['startTime'] ?? 'N/A',
      endTime: data['endTime'] ?? 'N/A',
      leaderId: data['leaderId'] ?? 'N/A',
      logoUrl: data['logoUrl'] ?? 'N/A',
      targetProgress: data['targetProgress'] ?? 0,
      teamName: data['teamName'] ?? 'No Team',
      type: data['type'] ?? 'No Type',
      workType: data['workType'] ?? 'No Work Type',
      teamMembers: List<Map<String, dynamic>>.from(data['teamMembers'] ?? []),
    );
  }
}
