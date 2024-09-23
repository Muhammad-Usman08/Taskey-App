import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/custom_app_bar.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/TodayTaskView/TodayTaskViewComponent/hourly_task_cards.dart';
import 'package:taskey_app/views/TodayTaskView/TodayTaskViewComponent/today_monthly_card.dart';
import 'package:taskey_app/views/TodayTaskView/today_task_view_model.dart';

class TodayTaskView extends StatelessWidget {
  const TodayTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final TodayTaskViewModel controller = Get.put(TodayTaskViewModel());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(
          icon: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          icon2: IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit_outlined),
          ),
          title: 'Today Task',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TodayMonthlyCard(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    String day = controller.getDay(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return GestureDetector(
                          onTap: () => controller.toggleSelection(index),
                          child: Container(
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
                                        : Colors.grey.shade500),
                              ],
                            ),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: controller.selectedDay.value == index
                                  ? Color(themeColor)
                                  : Colors.white,
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
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: avatarColors.length,
              itemBuilder: (context, index) {
                bool isEven = index % 2 == 0;
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: isEven
                        ? Row(
                            children: [
                              Container(
                                  width: 80,
                                  height: 1,
                                  color: Colors.grey.shade400),
                              HourlyTaskCards(index: index),
                            ],
                          )
                        : Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -1,
                                child: Container(
                                    width: 125,
                                    height: 1,
                                    color: Colors.grey.shade400),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 115,
                                  ),
                                  HourlyTaskCards(index: index),
                                ],
                              ),
                              Positioned(
                                left: -1,
                                bottom: -1,
                                child: Container(
                                    width: 125,
                                    height: 1,
                                    color: Colors.grey.shade400),
                              ),
                            ],
                          ));
              },
            )
          ],
        ),
      ),
    );
  }
}

String getTimeForIndex(int index) {
  int startHour = 10 + index; // Example: starts from 10 AM
  int endHour = startHour + 1;
  return '$startHour:00 - $endHour:00';
}
