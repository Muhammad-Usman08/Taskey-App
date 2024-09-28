import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/project/componenet/project_card.dart';
import 'package:taskey_app/views/task/task_view_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskEditViewModel viewModel = Get.put(TaskEditViewModel());
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    viewModel.fetchUserTasks();

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Task Status',
          weight: FontWeight.w500,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      return DropdownButton<String>(
                        hint: const Text('Select Task'),
                        value: viewModel.selectedTaskId.value.isNotEmpty
                            ? viewModel.selectedTaskId.value
                            : null,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            viewModel.selectTask(newValue);
                          }
                        },
                        items: viewModel.userTasks
                            .map<DropdownMenuItem<String>>((task) {
                          var taskData = task.data() as Map<String, dynamic>;
                          return DropdownMenuItem<String>(
                            value: task.id,
                            child: Text(taskData['taskName']),
                          );
                        }).toList(),
                      );
                    }),
                    const SizedBox(height: 20),
                    Obx(() {
                      double progressValue = viewModel.currentProgress.value;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              color: Color(themeColor),
                              backgroundColor:
                                  Color(themeColor).withOpacity(0.2),
                              value: progressValue, // Set the progress value
                              strokeWidth: 6,
                            ),
                          ),
                          CustomText(
                            text:
                                '${(progressValue * 100).toStringAsFixed(0)}%', // Display percentage

                            fontSize: 24,
                            weight: FontWeight.bold,
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 30),
                    const CustomText(
                      text: 'My Tasks or Projects',
                      weight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: viewModel.getTask(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No tasks available.'));
                  }

                  var taskDocuments = snapshot.data!.docs;

                  // Filter for projects that are assigned to the current user
                  var userTasks = taskDocuments.where((doc) {
                    var taskData = doc.data() as Map<String, dynamic>;
                    var teamMembers = taskData['teamMembers'] as List;
                    return teamMembers
                        .any((member) => member['userId'] == currentUserId);
                  }).toList();

                  // Further filter for projects

                  if (userTasks.isEmpty) {
                    return Center(child: Text('No projects available.'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userTasks.length,
                    itemBuilder: (context, index) {
                      var taskData =
                          userTasks[index].data() as Map<String, dynamic>;
                      String taskId = userTasks[index].id;

                      List<dynamic> teamMembers =
                          taskData['teamMembers'] as List<dynamic>;
                      List<String> imageUrls = teamMembers.map((member) {
                        return member['imageUrl'] as String;
                      }).toList();

                      return GestureDetector(
                        onTap: () {
                          if (taskData['leaderId'] == currentUserId) {
                            _showProgressDialog(context, taskId,
                                taskData['userProgress'], viewModel);
                          } else {
                            Get.defaultDialog(
                                cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('Ok')),
                                title: 'You are not leader',
                                content: CustomText(
                                  text: 'Only Leader can Update Progress',
                                ));
                          }
                        },
                        child: ProjectCard(
                          length: imageUrls.length,
                          image: imageUrls,
                          taskTitles:
                              taskData['taskName'] as String? ?? 'No Task Name',
                          taskSubtitles:
                              taskData['desc'] as String? ?? 'No Description',
                          value: (taskData['targetProgress'] > 0)
                              ? (taskData['userProgress'] /
                                  taskData['targetProgress'])
                              : 0.0,
                          index: index,
                          progressValues: taskData['userProgress'],
                          totalValues: taskData['targetProgress'],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProgressDialog(BuildContext context, String taskId,
      int currentProgress, TaskEditViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int newProgress = currentProgress; // Default to current progress
        return AlertDialog(
          title: Text('Update Task Progress'),
          content: DropdownButton<int>(
            value: newProgress,
            items: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
                .map((value) => DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value%'),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                newProgress = value;
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the task progress
                viewModel.updateProgress(taskId, newProgress);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
