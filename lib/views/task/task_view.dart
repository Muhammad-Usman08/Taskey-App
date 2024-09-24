import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Status'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/Task.png", // Replace with your image path
                  width: 150, // Set the smaller width you want
                  height: 150, // Set the smaller height you want
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
                const SizedBox(
                    height: 20), // Space between the image and circles
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatusCircle(Colors.greenAccent, 'To-Do'),
                    const SizedBox(
                        width: 20), // Space between the first and second set
                    _buildStatusCircle(Colors.orangeAccent, 'In Progress'),
                    const SizedBox(
                        width: 20), // Space between the second and third set
                    _buildStatusCircle(Colors.blue, 'Completed'),
                  ],
                ),
                const SizedBox(height: 20), // Space after status circles
                Container(
                  child: const Text(
                    'Monthly',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                    height: 10), // Space between Monthly text and list
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildTaskCard('To-Do', Colors.greenAccent),
                _buildTaskCard('In Progress', Colors.orangeAccent),
                _buildTaskCard('Completed', Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCircle(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Only take as much space as needed
      children: [
        CircleAvatar(
          backgroundColor: color, // Circle color
          radius: 20, // Circle radius
        ),
        const SizedBox(width: 8), // Space between circle and text
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTaskCard(String title, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2), // Light background color
        borderRadius: BorderRadius.circular(10), // Rounded corners
        border: Border.all(color: color), // Border color
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
