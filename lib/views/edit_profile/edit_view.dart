import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_texfield.dart';
import 'package:taskey_app/utils/constants.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String imageUrl =
      'https://cdn.pixabay.com/photo/2015/01/12/10/44/woman-597173_640.jpg'; // Default image URL
  bool isProfileSaved = false; // Track whether the profile is saved

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageUrl = image.path; // Update to the new selected image
      });
    }
  }

  void _saveProfile() {
    setState(() {
      // Switch to the second image when saving
      isProfileSaved = true;

      // Clear text fields
      _nameController.clear();
      _emailController.clear();
      _usernameController.clear();
      _contactController.clear();
    });

    // Show Snackbar at the top
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile Saved!'),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayImageUrl = isProfileSaved
        ? 'https://cdn.pixabay.com/photo/2016/03/27/17/40/man-1283231_640.jpg'
        : imageUrl;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(displayImageUrl),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'Name',
            ),
            SizedBox(height: 15),
            CustomTextField(
              hintText: 'Email',
            ),
            SizedBox(height: 15),
            CustomTextField(
              hintText: 'User Name',
            ),
            SizedBox(height: 15),
            CustomTextField(
              hintText: 'Contact',
            ),
            SizedBox(height: 20),
            CommonButton(
              title: 'Save',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
