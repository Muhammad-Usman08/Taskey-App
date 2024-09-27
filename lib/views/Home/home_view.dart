import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/custom_app_bar.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/home/homeComponent/in_progress_tile.dart';
import 'package:taskey_app/views/home/homeComponent/task_card.dart';
import 'package:taskey_app/views/home/home_view_model.dart';
import 'package:taskey_app/views/TodayTaskView/today_task_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeViewModel controller = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    String date = controller.formattedDate();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: CustomAppBar(
            icon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.dashboard_outlined,
                )),
            icon2: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                )),
            title: date,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Let’s make a \nhabits together  🙌 ',
                weight: FontWeight.bold,
                fontSize: 30,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: StreamBuilder(
                  stream: controller.getTask(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var taskDocuments = snapshot.data!.docs;

                      if (taskDocuments.isEmpty) {
                        return const Center(
                          child: Text('No tasks available.'),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: taskDocuments.length,
                        itemBuilder: (context, index) {
                          var taskData = taskDocuments[index].data()
                              as Map<String, dynamic>;

                          return TaskCard(
                            index: index,
                            taskName: taskData['taskName'] as String? ??
                                'No Task Name',
                            taskDescription:
                                taskData['desc'] as String? ?? 'No Description',
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const CustomText(
                  text: 'in Progress',
                  weight: FontWeight.bold,
                  fontSize: 25,
                ),
                InkWell(
                    onTap: () {
                      Get.to(const TodayTaskView());
                    },
                    child: const Icon(Icons.arrow_forward_ios)),
              ]),
              const SizedBox(height: 10),
              StreamBuilder(
                stream: controller.getTask(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var taskDocuments = snapshot.data!.docs;

                    if (taskDocuments.isEmpty) {
                      return const Center(
                        child: Text('No tasks available.'),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: taskDocuments.length,
                      itemBuilder: (context, index) {
                        var taskData =
                            taskDocuments[index].data() as Map<String, dynamic>;

                        return InProgressTile(
                          index: index,
                          taskName:
                              taskData['taskName'] as String? ?? 'No Task Name',
                          taskDescription:
                              taskData['desc'] as String? ?? 'No Description',
                          startTime: taskData['startTime'],
                          endTime: taskData['endTime'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
