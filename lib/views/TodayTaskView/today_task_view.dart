import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/custom_app_bar.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/TodayTaskView/TodayTaskViewComponent/hourly_task_cards.dart';
import 'package:taskey_app/views/TodayTaskView/TodayTaskViewComponent/today_monthly_card.dart';
import 'package:taskey_app/views/TodayTaskView/today_task_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TodayTaskView extends StatelessWidget {
  const TodayTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodayTaskViewModel controller = Get.put(TodayTaskViewModel());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(
          icon: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          icon2: IconButton(
            onPressed: () {}, // Add edit functionality if needed
            icon: Icon(Icons.edit_outlined),
          ),
          title: 'Today Task',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          children: [
            TodayMonthlyCard(),
            SizedBox(height: 10),
            _buildDateSelector(controller),
            SizedBox(height: 15),
            Divider(),
            Expanded(
              child: Obx(() {
                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('tasks')
                      .where('date',
                          isEqualTo: DateFormat('MMMM d, yyyy').format(
                              DateTime.now().subtract(Duration(
                                  days: 29 - controller.selectedDay.value))))
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Text('No tasks found for this day.'));
                    }

                    List<Task> tasks = snapshot.data!.docs.map((doc) {
                      Task task = Task.fromFirestore(doc);
                      print(
                          'Task: ${task.taskName}, Date: ${task.date}'); // Debugging log
                      return task;
                    }).toList();

                    print(
                        'Total tasks to display: ${tasks.length}'); // Debugging log

                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return _buildTaskCard(tasks[index],);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(TodayTaskViewModel controller) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30,
        itemBuilder: (context, index) {
          String day = controller.getDay(index);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Obx(() {
              return GestureDetector(
                onTap: () {
                  controller.selectedDay.value = index;
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: controller.selectedDay.value == index
                        ? Color(themeColor)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: '${index + 1}',
                        fontSize: 25,
                        color: controller.selectedDay.value == index
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                      CustomText(
                        text: day,
                        fontSize: 25,
                        color: controller.selectedDay.value == index
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildTaskCard(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: HourlyTaskCard(task: task), // Pass the individual task
    );
  }
}
