import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  List<bool> isSelected = [false, false, false, false];

  Widget _buildLanguageCard(String language, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          setState(() {
            isSelected[index] = !isSelected[index];
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: language,
                weight: FontWeight.w500,
                fontSize: 18,
              ),
              Switch(
                value: isSelected[index],
                onChanged: (value) {
                  setState(() {
                    isSelected[index] = value;
                  });
                },
                activeColor: Color(themeColor), // Change color when active
                inactiveTrackColor:
                    Colors.grey[300], // Change color when inactive
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const CustomText(
            text: 'Language',
            weight: FontWeight.w500,
            fontSize: 20,
          ),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          children: ['English', 'Urdu', 'French', 'German']
              .asMap()
              .entries
              .map((entry) => _buildLanguageCard(entry.value, entry.key))
              .toList(),
        ),
      ),
    );
  }
}
