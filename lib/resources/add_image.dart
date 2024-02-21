import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:verificationsystem/app_export.dart';
import 'package:path/path.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

UploadImageToStore _store = UploadImageToStore();

class StoreImage {
  String userId = ""; // placeholder for user's id

  // Function to upload an image file to Firebase Storage
  Future<void> uploadImagetoStorage(
      {required String documentType, required File imgfile}) async {
    try {
      userId = await RegisterAuth().getCurrentUserId();

      String fileName = basename(imgfile.path);

      // Storage path based on user UID and document type
      String storagePath = 'documents/$userId/$documentType/$fileName';

      Reference ref = _storage.ref().child(storagePath);
      UploadTask uploadTask = ref.putFile(imgfile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      _store.docDetails[documentType] = downloadUrl;

      if (_store.docDetails.length == 3) {
        print(_store.docDetails.length);
        _store.saveImage();
      }
    }

    //handle if there is any error while uploading image
    catch (error) {
      print("Error uploading image to storage: $error");
    }
  }
}
