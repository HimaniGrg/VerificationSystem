import 'dart:io';
import 'package:image_picker/image_picker.dart';

// function to pick image from gallery
pickImage(ImageSource source) async {
  try {
    final ImagePicker imagePicker = ImagePicker();
    XFile? xfile = await imagePicker.pickImage(
        source:
            source); // the function returns a X file so we save it in variable named _file.
    //check if file has image
    if (xfile != null) {
      //return file as bytes
      File file = File(xfile.path);
      return file;
    } else {
      print("No images selected.");
    }
  } catch (e) {
    print("Error while picking image: $e");
  }
}
