import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/custom_app_bar.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/project/componenet/my_custom_textField.dart';
import 'package:taskey_app/views/project/componenet/project_card.dart';
import 'package:taskey_app/views/project/project_view_model.dart';

class ProjectView extends StatelessWidget {
  final ProjectViewModel viewModel = Get.put(ProjectViewModel());

  @override
  Widget build(BuildContext context) {
    List<String> per = ['Favourite', 'Recent', 'All'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(
          icon: IconButton(
            onPressed: () {
              // Handle back action
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          icon2: IconButton(
            onPressed: () {
              // Handle add action
              // Your add logic here
            },
            icon: Icon(Icons.add),
          ),
          title: 'Projects',
        ),
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
                                          ? Colors.black // Selected text color
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
              ProjectCard(),
            ],
          ),
        ),
      ),
    );
  }
}
