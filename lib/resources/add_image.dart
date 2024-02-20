import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../auth/register_auth.dart';
import 'package:path/path.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

String userId = ""; // placeholder for user's id

class StoreImage {
  // Function to upload an image file to Firebase Storage
  Future<String> uploadImagetoStorage(String documentType, File imgfile) async {
    try {
      userId = await RegisterAuth().getCurrentUserId();

      String fileName = basename(imgfile.path);

      // Storage path based on user UID and document type
      String storagePath = 'users/$userId/$documentType/$fileName';

      Reference ref = _storage.ref().child(storagePath);
      UploadTask uploadTask = ref.putFile(imgfile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    //handle if there is any error while uploading image
    catch (error) {
      print("Error uploading image to storage: $error");
      throw "Upload failed: $error"; // Return an error message
    }
  }

  // function to save image details to Firebase cloud firestore
  Future<void> saveImage(
      {required String documentType, required File file}) async {
    try {
      // get download urls after uploading images to storage
      String imageUrl = await uploadImagetoStorage(documentType, file);
      // save the download url in firestore
      await _firestore.collection('Documents').doc(userId).set({
        'documentType': documentType,
        'imageUrl': imageUrl,
      });
      print("image saved");
    } catch (e) {
      // Handle any errors that occur during the save process
      print("Error saving image: $e");
      throw "Save failed: $e"; // Return an error message
    }
  }
}
