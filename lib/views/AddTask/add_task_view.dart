import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_app_bar.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/AddTask/add_task_view_model.dart';
import 'package:taskey_app/views/AddTask/component/date_picker.dart';
import 'package:taskey_app/views/AddTask/component/time_picker.dart';
import 'package:taskey_app/views/main/main_screen.dart';
import 'package:taskey_app/views/project/componenet/my_custom_textField.dart';
import 'package:taskey_app/views/settings/setting_view_model.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    TextEditingController teamNameController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController subTitle = TextEditingController();
    TextEditingController startTimeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();

    final AddTaskViewModel controller = Get.put(AddTaskViewModel());
    final SettingViewModel settingViewModel = Get.put(SettingViewModel());

    controller.fetchUsers();

    // Helper function to get colors based on dark mode
    Color getColor(Color lightColor, Color darkColor) {
      return settingViewModel.isDarkModeEnabled == true
          ? darkColor
          : lightColor;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar2(
          icon: IconButton(
            onPressed: () {
              Get.to(MainScreen());
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: 'Create Task Or Project',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      return Container(
                        height: 80,
                        width: 80,
                        child: controller.logoUrl.value.isEmpty
                            ? SvgPicture.asset('assets/svg/Group.svg',
                                fit: BoxFit.scaleDown)
                            : ClipOval(
                                child: Image.network(controller.logoUrl.value,
                                    fit: BoxFit.cover),
                              ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(themeColor),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        await controller.selectLogo();
                      },
                      child: CustomText(
                        text: 'Upload Logo file',
                        weight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    CustomText(
                      text: 'Your logo always publish',
                      color: getColor(Colors.grey.shade700, Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomText(
                text: 'Select Work Type:',
                color: getColor(Colors.grey.shade500, Colors.white),
                weight: FontWeight.w700,
              ),
              Obx(() {
                return DropdownButton<String>(
                  hint: Text('Select Action'),
                  value: controller.selectedOption.value.isEmpty
                      ? null
                      : controller.selectedOption.value,
                  onChanged: controller.updateOption,
                  items: <String>['Task', 'Project'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              }),
              SizedBox(height: 20),
              Obx(() {
                if (controller.selectedOption.value == 'Task') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Task Name',
                        color: getColor(Colors.grey.shade500, Colors.white),
                        weight: FontWeight.w700,
                      ),
                      SizedBox(height: 15),
                      MyCustomTextfield(
                        hintText: 'Add a Task',
                        controller: taskController,
                      ),
                      SizedBox(height: 10),
                      CustomText(
                        text: 'Description',
                        weight: FontWeight.bold,
                        color: getColor(Colors.grey.shade700, Colors.white),
                        fontSize: 18,
                      ),
                      SizedBox(height: 15),
                      MyCustomTextfield(
                        hintText: 'Enter Short Description',
                        controller: subTitle,
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                } else if (controller.selectedOption.value == 'Project') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Project Name',
                        color: getColor(Colors.grey.shade500, Colors.white),
                        weight: FontWeight.w700,
                      ),
                      SizedBox(height: 15),
                      MyCustomTextfield(
                        hintText: 'Add a Project',
                        controller: taskController,
                      ),
                      SizedBox(height: 15),
                      CustomText(
                        text: 'Project Description',
                        color: getColor(Colors.grey.shade500, Colors.white),
                        weight: FontWeight.w700,
                      ),
                      SizedBox(height: 15),
                      MyCustomTextfield(
                        hintText: 'Enter Short Description',
                        controller: subTitle,
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                } else {
                  return Text('Please select an action.');
                }
              }),
              SizedBox(height: 15),
              CustomText(
                text: 'Team Members',
                color: getColor(Colors.grey.shade500, Colors.white),
                weight: FontWeight.w700,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Obx(() {
                    return Row(
                      children:
                          List.generate(controller.teamMembers.length, (i) {
                        final member = controller.teamMembers[i];
                        final isLeader =
                            controller.leaderId.value == member['userId'];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              controller.setLeader(member['userId']);
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(member['imageUrl']),
                                      radius: 25,
                                    ),
                                    if (isLeader)
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                      ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                                Center(
                                  child: CustomText(
                                    text: member['username'],
                                    color: getColor(
                                        Colors.grey.shade700, Colors.white),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Select Team Member'),
                            content: SizedBox(
                              height: 200,
                              width: double.maxFinite,
                              child: Obx(() {
                                return ListView.builder(
                                  itemCount: controller.users.length,
                                  itemBuilder: (context, index) {
                                    final user = controller.users[index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: user['imageUrl'] !=
                                                    null &&
                                                user['imageUrl'].isNotEmpty
                                            ? NetworkImage(user['imageUrl'])
                                            : NetworkImage(
                                                'https://cdn-icons-png.freepik.com/256/7162/7162968.png?ga=GA1.1.1256163933.1675831381&semt=ais_hybrid'),
                                      ),
                                      title: Text(user['username']),
                                      onTap: () {
                                        controller.addTeamMember(user);
                                        Get.back();
                                      },
                                    );
                                  },
                                );
                              }),
                            ),
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Color(themeColor),
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(themeColor)),
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomText(
                          text: 'Add',
                          weight: FontWeight.bold,
                          color: getColor(Colors.grey.shade700, Colors.white),
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomText(
                text: 'Team Name',
                weight: FontWeight.bold,
                color: getColor(Colors.grey.shade700, Colors.white),
                fontSize: 18,
              ),
              SizedBox(height: 10),
              MyCustomTextfield(
                hintText: 'Enter Team Name',
                controller: teamNameController,
              ),
              SizedBox(height: 10),
              CustomText(
                text: 'Date',
                weight: FontWeight.bold,
                color: getColor(Colors.grey.shade700, Colors.white),
                fontSize: 18,
              ),
              SizedBox(height: 15),
              DatePicker(
                controller: dateController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      CustomText(
                        text: 'Start Time',
                        weight: FontWeight.bold,
                        color: getColor(Colors.grey.shade700, Colors.white),
                        fontSize: 18,
                      ),
                      SizedBox(height: 15),
                      TimePicker(
                        controller: startTimeController,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      CustomText(
                        text: 'End Time',
                        color: getColor(Colors.grey.shade700, Colors.white),
                        fontSize: 18,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: 15),
                      TimePicker(
                        controller: endTimeController,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomText(
                text: 'Board',
                color: getColor(Colors.grey.shade500, Colors.white),
                fontSize: 18,
                weight: FontWeight.bold,
              ),
              SizedBox(height: 15),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(controller.board.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.updateBoard(controller.board[index]);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: controller.selectedBoard.value ==
                                    controller.board[index]
                                ? Color(themeColor)
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomText(
                          text: controller.board[index],
                          color: controller.selectedBoard.value ==
                                  controller.board[index]
                              ? getColor(Colors.grey.shade800, Colors.white)
                              : getColor(Colors.grey.shade500, Colors.white),
                          weight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                );
              }),
              SizedBox(height: 10),
              CustomText(
                text: 'Type',
                color: getColor(Colors.grey.shade500, Colors.white),
                fontSize: 18,
                weight: FontWeight.bold,
              ),
              SizedBox(height: 15),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(controller.type.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.updateType(controller.type[index]);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: controller.typeTask.value ==
                                    controller.type[index]
                                ? Color(themeColor)
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomText(
                          text: controller.type[index],
                          color: controller.typeTask.value ==
                                  controller.type[index]
                              ? getColor(Colors.grey.shade800, Colors.white)
                              : getColor(Colors.grey.shade400, Colors.white),
                          weight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                );
              }),
              SizedBox(height: 30),
              Center(
                child: CommonButton(
                  onPressed: () async {
                    print('Task Name: ${taskController.text.trim()}');

                    await controller.saveTask(
                      taskController.text.trim(),
                      teamNameController.text.trim(),
                      dateController.text.trim(),
                      startTimeController.text.trim(),
                      endTimeController.text.trim(),
                      subTitle.text.trim(),
                    );

                    taskController.clear();
                    teamNameController.clear();
                    dateController.clear();
                    startTimeController.clear();
                    endTimeController.clear();
                    subTitle.clear();
                    controller.logoUrl.value = '';
                    controller.teamMembers.clear();
                    controller.selectedBoard.value = controller.board[0];
                    controller.typeTask.value = controller.type[0];
                  },
                  vertcalPaddingM: 15,
                  horizontalPadding: 160,
                  title: 'Save',
                  bgColor: Color(themeColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
