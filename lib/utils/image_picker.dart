import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// function to pick from gallery
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(
      source:
          source); // the function returns a X file so we save it in variable named _file.
  //check if file has image
  if (_file != null) {
    return await _file.readAsBytes();
  } else {
    print("No images selected.");
  }
}
