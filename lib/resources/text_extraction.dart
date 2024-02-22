import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:path_provider/path_provider.dart';
import 'package:verificationsystem/app_export.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class TextExtraction {
  String userId = "";
  Map<String, String> imageUrls = {};
  Map<String, String> extractedData = {};

  Future<Map<String, String>> extractText() async {
    userId = await RegisterAuth().getCurrentUserId();
    await getImageUrls(userId);
    try {
      // Iterate through image URLs
      for (String documentType in imageUrls.keys) {
        String imageUrl = imageUrls[documentType]!;
        // print(imageUrl);

        // Download the image from the URL
        File imageFile = await downloadImage(imageUrl);

        // Use Tesseract OCR to extract text from the image URL
        final text = await FlutterTesseractOcr.extractText(
          imageFile.path,
          language: 'eng',
        );

        //print(text);

        // Save extracted text
        extractedData[documentType] = text;
      }

      // print(
      //     "Citizenship_back: ${extractedData['citizenship_back']} \n Citizenship_front: ${extractedData['citizenship_front']} \n License: ${extractedData['license']}");
      print("Extraction complete!");
      print(extractedData.entries);
      return extractedData;
    } catch (e) {
      throw ('Error extracting text: $e');
    }
  }

  // function to download image from Firebase cloud firestore
  Future<void> getImageUrls(String userId) async {
    try {
      //fetch image urls from firestore
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('Documents').doc(userId).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        imageUrls = {
          'license': documentSnapshot['license'],
          'citizenship_back': documentSnapshot['citizenship_back'],
          'citizenship_front': documentSnapshot['citizenship_front'],
        };

        //print("${imageUrls['citizenship_back']} \n ${imageUrls['citizenship_front']} \n ${imageUrls['license']}");
        //return imageUrls;
      } else {
        throw "Document does not exist for userId: $userId";
      }
    } catch (e) {
      throw "Failed to retrieve image URLs: $e";
    }
  }

  Future<File> downloadImage(String imageUrl) async {
    try {
      // Create a temporary directory to store the image
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Create a local file with a unique name
      File imageFile =
          File('$tempPath/${DateTime.now().millisecondsSinceEpoch}.png');

      // Download the image and write it to the local file
      var response = await http.get(Uri.parse(imageUrl));
      await imageFile.writeAsBytes(response.bodyBytes);

      return imageFile;
    } catch (e) {
      throw ('Error downloading image: $e');
    }
  }
}
