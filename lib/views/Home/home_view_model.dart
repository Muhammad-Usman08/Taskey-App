import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends GetxController {
  List<int> progressValues = [50, 30, 70];
  List<int> totalValues = [80, 100, 90];
  final data = RxList();
  var firestore = FirebaseFirestore.instance.collection('tasks');

  String formattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE, d').format(now);
  }

  Stream<QuerySnapshot> getTask() {
    return firestore.snapshots();
  }

  List inProgress = [
    {
      'title': 'Productivity Mobile App',
      'subtitle': 'Create Detail Booking',
      'time': '2 min ago',
    },
    {
      'title': 'Banking Mobile App',
      'subtitle': 'Revision Home Page',
      'time': '5 min ago',
    },
    {
      'title': 'Online Course',
      'subtitle': 'Working On Landing Page',
      'time': '7 min ago',
    },
  ];
}
