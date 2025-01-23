import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();

  Future<void> uploadImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Upload the file to Supabase Storage
      final response = await Supabase.instance.client.storage.from('images').upload(
        'images/${pickedFile.name}', // The file path in your storage
        imageFile,
      );

      if (response.error != null) {
        print('Error uploading image: ${response.error!.message}');
      } else {
        print('Image uploaded successfully!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: Center(
        child: ElevatedButton(
          onPressed: uploadImage,
          child: Text('Upload Image'),
        ),
      ),
    );
  }
}
