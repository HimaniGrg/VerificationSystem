import 'package:verificationsystem/app_export.dart';
import 'package:string_similarity/string_similarity.dart';

class TextVerification {
  double? verifyDoc(Map citizenshipMap, Map licenseMap) {
    print(citizenshipMap.keys);

    if (citizenshipMap.isNotEmpty || licenseMap.isNotEmpty) {
      double similarityName =
          calculateSimilarity(citizenshipMap['Name']!, licenseMap['Name']!);
      print("Similarity Percentage for Name: $similarityName%");

      double similarityDOB = calculateSimilarity(
          citizenshipMap['Date of Birth']!, licenseMap['Date of Birth']!);
      print("Similarity Percentage for DOB: $similarityDOB%");

      double similarityCitizenshipNo = calculateSimilarity(
          citizenshipMap['Citizenship No.']!, licenseMap['Citizenship No.']!);
      print(
          "Similarity Percentage for Citizenship No.: $similarityCitizenshipNo%");

      double similarityPercentage =
          ((similarityName + similarityDOB + similarityCitizenshipNo) / 3);
      return similarityPercentage;
    }
  }

  double calculateSimilarity(String value1, String value2) {
    double similarity = value1.similarityTo(value2);
    return similarity * 100; // Convert to percentage
  }
}
