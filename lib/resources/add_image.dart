import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreImage {
  Future<String> uploadImagetoStorage(String filename, File file) async {
    Reference ref = _storage.ref().child(filename);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveImage(
      {required String filename, required File file}) async {
    String resp = "Response";
    try {
      if (filename.isNotEmpty) {
        String imageUrl = await uploadImagetoStorage(filename, file);
        await _firestore.collection('Documents').add({
          'documentType': filename,
          'imageLink': imageUrl,
        });
      }
      resp = "Image saved";
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }
}
