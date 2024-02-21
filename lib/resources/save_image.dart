import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verificationsystem/app_export.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
StoreImage _storeImage = StoreImage();

class UploadImageToStore {
  Map<String, String> docDetails = {};

  String userId = "";
  // function to save image details to Firebase cloud firestore
  Future<void> saveImage() async {
    try {
      userId = await RegisterAuth().getCurrentUserId();
      print(userId);
      print(userId.isEmpty);
      // save the image details; document type and download url in firestore
      await _firestore.collection('Documents').doc(userId).set({
        ...docDetails,
      });
      print("Document updated sucessfully");
    } catch (e) {
      // Handle any errors that occur during the save process
      print("Error saving image: $e");
    }
  }
}
