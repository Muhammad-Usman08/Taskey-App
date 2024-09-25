import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomText(
          text: 'Task Status',
          weight: FontWeight.w500,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/Task.png",
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatusCircle(Colors.greenAccent, 'To-Do'),
                      const SizedBox(width: 20),
                      _buildStatusCircle(Colors.orangeAccent, 'In Progress'),
                      const SizedBox(width: 20),
                      _buildStatusCircle(Colors.blue, 'Completed'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const CustomText(
                      text: 'Monthly', weight: FontWeight.bold, fontSize: 20),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildTaskCard('To-Do'),
                  _buildTaskCard('In Progress'),
                  _buildTaskCard('Completed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCircle(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: color, // Circle color
          radius: 5,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildTaskCard(
    String title,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(themeColor)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert), // Three-dot icon
            onSelected: (value) {
              // Handle the selection
              switch (value) {
                case 'edit':
                  // Handle edit action
                  break;
                case 'delete':
                  // Handle delete action
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
