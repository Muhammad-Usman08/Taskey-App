import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/custom_app_bar.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/MonthlyTask/MonthlyComponents/monthly_card.dart';
import 'package:taskey_app/views/MonthlyTask/monthly_task_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyTaskView extends StatelessWidget {
  const MonthlyTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final MonthlyTaskViewModel controller = Get.put(MonthlyTaskViewModel());

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
          title: 'Monthly Task',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: MonthlyCard(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Obx(() {
                // Get the days for the currently selected month
                final daysInMonth =
                    controller.getDaysInMonth(controller.selectedDate.value);
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: daysInMonth.length,
                    itemBuilder: (context, index) {
                      DateTime dayDate = DateTime(
                          controller.selectedDate.value.year,
                          controller.selectedDate.value.month,
                          index + 1); // Current month

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() {
                          return GestureDetector(
                            onTap: () {
                              controller.toggleSelection(index);
                              controller.selectedDate.value =
                                  dayDate; // Update selected date
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text:
                                        '${dayDate.day}', // Use dayDate.day for display
                                    fontSize: 25,
                                    color: controller.selectedDayIndex.value ==
                                            index
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                  ),
                                  CustomText(
                                    text: daysInMonth[index], // Get day name
                                    fontSize: 25,
                                    color: controller.selectedDayIndex.value ==
                                            index
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                  ),
                                ],
                              ),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color:
                                    controller.selectedDayIndex.value == index
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
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Obx(() {
                return TableCalendar(
                  firstDay: DateTime.now().subtract(Duration(days: 30)),
                  lastDay: DateTime.now().add(Duration(days: 30)),
                  focusedDay: controller.selectedDate.value,
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDate.value, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.selectedDate.value = selectedDay;
                    controller.toggleSelection(
                        selectedDay.day - 1); // Adjust for index
                  },
                  calendarFormat: CalendarFormat.month,
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                        color: Color(themeColor),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(Icons.chevron_left),
                    rightChevronIcon: Icon(Icons.chevron_right),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color(themeColor),
                      shape: BoxShape.circle,
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
