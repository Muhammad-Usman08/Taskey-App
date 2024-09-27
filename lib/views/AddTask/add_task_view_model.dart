import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddTaskViewModel extends GetxController {
  var selectedOption = 'Task'.obs; // Task or Project
  var selectedBoard = 'Urgent'.obs; // Urgent, Running, Ongoing
  var typeTask = 'Private'.obs; // Private, Public, Secret
  var users = [].obs;
  var logoUrl = ''.obs;

  var teamMembers = <Map<String, dynamic>>[].obs; // Store team member data
  var leaderId = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> selectLogo() async {
    try {
      XFile? logoFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (logoFile != null) {
        await uploadLogo(logoFile);
      }
    } catch (e) {
      print('Error selecting logo: $e');
    }
  }

  Future<void> uploadLogo(XFile logo) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('logos/${logo.name}');
      await storageRef.putFile(File(logo.path));

      logoUrl.value = await storageRef.getDownloadURL();
      print('Logo uploaded: $logoUrl');
    } catch (e) {
      print('Error uploading logo: $e');
    }
  }

  void updateOption(String? newValue) {
    if (newValue != null) {
      selectedOption.value = newValue;
    }
  }

  void addTeamMember(Map<String, dynamic> member) {
    if (member['userId'] != null && member['username'] != null) {
      if (!teamMembers.any((m) => m['userId'] == member['userId'])) {
        teamMembers.add(member);
        print('Team member added: ${member['username']}'); // Debugging
      }
    } else {
      Get.snackbar("Error", "Invalid team member data.");
    }
  }

  void setLeader(String userId) {
    leaderId.value = userId;
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

  List<String> board = [
    'Urgent',
    'Running',
    'Ongoing',
  ];

  List<String> type = [
    'Private',
    'Public',
    'Secret',
  ];

  Future<void> fetchUsers() async {
    var usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    var usersData = usersSnapshot.docs
        .map((doc) => {
              'userId': doc.id,
              'username': doc['username'],
              'email': doc['email'],
              'imageUrl': doc['imageUrl'],
            })
        .toList();
    users.value = usersData; // Update the observable list of users
  }

  Future<void> saveTask(String taskName, String teamName, String date,
      String startTime, String endTime, String desc) async {
    if (taskName.isEmpty) {
      Get.snackbar("Error", "Task name cannot be empty.");
      return;
    }
    if (date.isEmpty) {
      Get.snackbar("Error", "Date cannot be empty.");
      return;
    }
    if (startTime.isEmpty) {
      Get.snackbar("Error", "Start time cannot be empty.");
      return;
    }
    if (endTime.isEmpty) {
      Get.snackbar("Error", "End time cannot be empty.");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'taskName': taskName,
        'desc': desc.isEmpty ? "No description provided" : desc,
        'logoUrl': logoUrl.value.isEmpty ? null : logoUrl.value,
        'teamName': teamName.isEmpty ? "Default Team" : teamName,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'leaderId': leaderId.value.isEmpty ? null : leaderId.value,
        'targetProgress': 100,
        'userProgress': 0,
        'teamMembers': teamMembers
            .map((m) => {
                  'userId': m['userId'],
                  'username': m['username'],
                  'email': m['email'],
                  'imageUrl': m['imageUrl'],
                })
            .toList(),
        'workType': selectedOption.value,
        'board': selectedBoard.value,
        'type': typeTask.value,
      });

      Get.snackbar("Success", "Task has been saved successfully!");
    } catch (e) {
      print("Error saving task: $e");
      Get.snackbar("Error", "Failed to save task: $e");
    }
  }
}
