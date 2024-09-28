import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/custom_app_bar.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/project/componenet/my_custom_textField.dart';
import 'package:taskey_app/views/project/componenet/project_card.dart';
import 'package:taskey_app/views/project/project_view_model.dart';
import 'package:taskey_app/views/settings/setting_view_model.dart';

class ProjectView extends StatelessWidget {
  final ProjectViewModel viewModel = Get.put(ProjectViewModel());
  final SettingViewModel settingViewModel = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    List<String> per = ['Favourite', 'Recent', 'All'];

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Projects',
          weight: FontWeight.bold,
          fontSize: 22,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyCustomTextfield(
                hintText: 'Search',
                prefix: Icon(Icons.search),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemCount: per.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  viewModel.selectIndex(
                                      index); // Use the method for better encapsulation
                                },
                                child: Container(
                                  height: 30,
                                  width: 100,
                                  child: Center(
                                    child: CustomText(
                                      text: per[index],
                                      weight: FontWeight.bold,
                                      color: viewModel.selectedIndex.value ==
                                              index
                                          ? (settingViewModel
                                                      .isDarkModeEnabled ==
                                                  false
                                              ? Colors.black
                                              : Colors
                                                  .white) // Selected text color
                                          : Colors
                                              .grey, // Unselected text color
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: viewModel.selectedIndex.value ==
                                              index
                                          ? Color(
                                              themeColor) // Selected border color
                                          : Colors
                                              .transparent, // Unselected border color
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.dashboard_outlined)),
                ],
              ),
              StreamBuilder(
                stream: viewModel.getTask(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No tasks available.'));
                  }

                  var taskDocuments = snapshot.data!.docs;

                  // Filter projects
                  var projectDocuments = taskDocuments.where((doc) {
                    var taskData = doc.data() as Map<String, dynamic>;
                    return taskData['workType'] == 'Project';
                  }).toList();

                  if (projectDocuments.isEmpty) {
                    return Center(child: Text('No projects available.'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: projectDocuments.length,
                    itemBuilder: (context, index) {
                      var taskData = projectDocuments[index].data()
                          as Map<String, dynamic>;

                      List<dynamic> teamMembers =
                          taskData['teamMembers'] as List<dynamic>;
                      List<String> imageUrls = teamMembers.map((member) {
                        return member['imageUrl'] as String;
                      }).toList();

                      return ProjectCard(
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
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
