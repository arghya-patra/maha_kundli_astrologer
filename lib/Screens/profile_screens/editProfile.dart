import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  String _profileImage = 'images/profile.jpeg'; // Initial profile image
  File? _image;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a loading delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.orange),
                title: const Text('Camera'),
                onTap: () async {
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_album, color: Colors.orange),
                title: const Text('Gallery'),
                onTap: () async {
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: _buildShimmerEffect(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      _image == null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(_profileImage)
                              //FileImage(File(_image!.path))
                              //_image!=null? FileImage(File(_image.path)):AssetImage(_profileImage),

                              // backgroundImage: AssetImage(_profileImage),
                              )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(File(_image!.path))
                              //_image!=null? FileImage(File(_image.path)):AssetImage(_profileImage),

                              // backgroundImage: AssetImage(_profileImage),
                              ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImageSourceActionSheet,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                      label: 'Full Name', controller: fullNameController),
                  const SizedBox(height: 16),
                  _buildTextField(label: 'Email', controller: emailController),
                  const SizedBox(height: 16),
                  _buildTextField(
                      label: 'Phone Number', controller: phoneNumberController),
                  const SizedBox(height: 16),
                  _buildTextField(
                      label: 'Password',
                      controller: passwordController,
                      isPassword: true),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Handle update functionality
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Update'),
                  ),
                  const Spacer(),
                  const Text(
                    'You joined on 2/22/2022',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Handle delete account functionality
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Delete Account',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildShimmerEffect() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        Container(
          height: 20,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        Container(
          height: 20,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        Container(
          height: 20,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        Container(
          height: 20,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 32),
        Container(
          height: 40,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        const Spacer(),
        Container(
          height: 20,
          width: 150,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        Container(
          height: 40,
          width: double.infinity,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}
