import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taskey_app/components/custom_app_bar.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/Home/HomeComponents/in_progress_tile.dart';
import 'package:taskey_app/views/Home/HomeComponents/task_card.dart';
import 'package:taskey_app/views/TodayTaskView/today_task_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomAppBar(
            icon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.dashboard_outlined,
                )),
            icon2: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                )),
            title: 'Friday, 26',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Let’s make a \nhabits together  🙌',
                weight: FontWeight.bold,
                fontSize: 30,
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 360,
                  itemCount: taskTitles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TaskCard(index: index),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                CustomText(
                  text: 'in Progress',
                  weight: FontWeight.bold,
                  fontSize: 25,
                ),
                InkWell(
                    onTap: () {
                      Get.to(TodayTaskView());
                    },
                    child: Icon(Icons.arrow_forward_ios)),
              ]),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: inProgress.length,
                itemBuilder: (context, index) {
                  return InProgressTile(index: index);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
