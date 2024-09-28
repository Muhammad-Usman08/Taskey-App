import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskEditViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid; // Get the current user ID



    var userTasks = <DocumentSnapshot>[].obs; 
  var selectedTaskId = ''.obs; 
  var currentProgress = 0.0.obs; 

  // Stream to get tasks assigned to the current user
    final data = RxList();
  var firestore = FirebaseFirestore.instance.collection('tasks');

 

  Stream<QuerySnapshot> getTask() {
    return firestore.snapshots();
  }

  // Update user progress for a specific task
  Future<void> updateProgress(String taskId, int newProgress) {
    return _firestore.collection('tasks').doc(taskId).update({
      'userProgress': newProgress,
    });
  }

   void fetchUserTasks() {
    getTask().listen((snapshot) {
      var taskDocuments = snapshot.docs;

      // Filter for tasks assigned to the current user
      userTasks.value = taskDocuments.where((doc) {
        var taskData = doc.data() as Map<String, dynamic>;
        var teamMembers = taskData['teamMembers'] as List;
        return teamMembers.any((member) => member['userId'] == currentUserId);
      }).toList();
    });
  }

  // Method to select a task and update the progress
  void selectTask(String taskId) {
    selectedTaskId.value = taskId;
    var selectedTask = userTasks.firstWhere((doc) => doc.id == taskId);
    var taskData = selectedTask.data() as Map<String, dynamic>;
    
    currentProgress.value = taskData['targetProgress'] > 0
        ? (taskData['userProgress'] / taskData['targetProgress'])
        : 0.0;
  }
}
