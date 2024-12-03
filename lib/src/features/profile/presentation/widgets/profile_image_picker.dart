import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/services/service_locator.dart';

class ProfileImagePicker extends StatefulWidget {
  final File? initialImage;
  final ValueChanged<File?> onImagePicked;

  const ProfileImagePicker({
    super.key,
    this.initialImage,
    required this.onImagePicked,
  });

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _imageFile;
  final ImagePicker _picker = getIt<ImagePicker>();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImagePicked(_imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[200],
        backgroundImage: _imageFile == null ? null : FileImage(_imageFile!),
        child: _imageFile == null
            ? Icon(
                Icons.camera_alt,
                size: 40,
                color: Colors.grey[600],
              )
            : null,
      ),
    );
  }
}
