class ExtractedData {
  String citizenshipBack = '';
  String citizenshipFront = '';
  String license = '';

  Map<String, String> TextFromCitizenship = {};
  Map<String, String> TextFromLicense = {};

  Map<String, String> TextToMapFromCitizenship() {
    List<String> lines = citizenshipBack.split('\n');

    // Extracting Full Name
    String line1 = lines.firstWhere((line) => line.startsWith('Full'));

    RegExp nameRegex = RegExp(r'Full Name\.(.+)', caseSensitive: false);
    String? nameMatch = nameRegex.firstMatch(line1)?.group(1)?.trim();

    // Extracting Date of Birth
    String line2 = lines.firstWhere((line) => line.startsWith('Date'));

    RegExp dobRegex = RegExp(
        r'Date of Birth \(AD\): Year (\d+) Month (\w+) Day (\d+)',
        caseSensitive: false);
    String? year = dobRegex.firstMatch(line2)?.group(1)?.trim();
    String? month = dobRegex.firstMatch(line2)?.group(2)?.trim();
    String? day = dobRegex.firstMatch(line2)?.group(3)?.trim();
    String? dobMatch = '$year-$month-$day';

    String line3 = lines.firstWhere((line) => line.startsWith('Citizenship'));

    // Extract Citizenship Certificate No.
    RegExp certificateNoRegex = RegExp(r'Citizenship Certificate No\. (\S+)');
    String? certificateNoMatch = certificateNoRegex.firstMatch(line3)?.group(1);

    // Extract Sex
    RegExp sexRegex = RegExp(r'Sex (\S+)');
    String? sexMatch = sexRegex.firstMatch(line3)?.group(1);

    // Store key-value pairs in the map
    TextFromCitizenship['Name'] = nameMatch!;
    TextFromCitizenship['Date of Birth'] = dobMatch;
    TextFromCitizenship['Citizenship No.'] = certificateNoMatch!;
    TextFromCitizenship['Sex'] = sexMatch!;

    print(TextFromCitizenship.entries);

    return TextFromCitizenship;
  }

  // Map<String, String> TextToMapFromLicense() {
  //   List<String> lines = citizenshipBack.split('\n');
  //   TextFromCitizenship['Name'] = lines
  //       .firstWhere((line) => line.startsWith('Full Name:'), orElse: () => '')
  //       .split('Full Name. ')
  //       .last
  //       .trim();

  //   TextFromCitizenship['Date of birth'] = lines
  //       .firstWhere((line) => line.startsWith('Date:'), orElse: () => '')
  //       .split('date of Birth (AD): ')
  //       .last
  //       .trim();

  //   TextFromCitizenship['Birth Place'] = lines
  //       .firstWhere((line) => line.startsWith('Birth'), orElse: () => '')
  //       .split('Birth place . ')
  //       .last
  //       .trim();

  //   String line = lines.firstWhere((line) => line.startsWith('Citizenship'));

  //   // Extract Citizenship Certificate No.
  //   RegExp certificateNoRegex = RegExp(r'Citizenship Certificate No\. (\S+)');
  //   String? certificateNoMatch = certificateNoRegex.firstMatch(line)?.group(1);

  //   // Extract Sex
  //   RegExp sexRegex = RegExp(r'Sex (\S+)');
  //   String? sexMatch = sexRegex.firstMatch(line)?.group(1);

  //   // Print the results
  //   TextFromCitizenship['Citizenship No.'] = certificateNoMatch!;
  //   TextFromCitizenship['Sex'] = sexMatch!;
  // }
}
