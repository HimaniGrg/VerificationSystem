class ExtractedData {
  String citizenshipBack = '';
  String citizenshipFront = '';
  String licenseText = '';

  Map<String, String> TextFromCitizenship = {
    'Name': '',
  };
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

    print(TextFromCitizenship['Name']);

    return TextFromCitizenship;
  }

  Map<String, String> TextToMapFromLicense() {
    List<String> lines = licenseText.split('\n');

    // Extracting Name
    // RegExp nameRegex = RegExp(r'L Name: (.+?) ;', caseSensitive: false);
    // String? nameMatch = nameRegex.firstMatch(licenseText)?.group(1)?.trim();
    // Extracting Name
    RegExp nameRegex =
        RegExp(r'(Name|Applicant ID): (.+?) ;', caseSensitive: false);
    String? nameMatch = nameRegex.firstMatch(licenseText)?.group(2)?.trim();

    // Extracting Date of Birth
    RegExp dobRegex =
        RegExp(r'D.O,I.:. (\d{2}-\d{2}-\d{4})', caseSensitive: false);
    String? dobMatch = dobRegex.firstMatch(licenseText)?.group(1)?.trim();

    // Extracting Citizenship No.
    RegExp citizenshipNoRegex =
        RegExp(r'Citizenship No.: (\S+)', caseSensitive: false);
    String? citizenshipNoMatch =
        citizenshipNoRegex.firstMatch(licenseText)?.group(1)?.trim();

    // Extracting Category
    RegExp categoryRegex = RegExp(r'Category: (\S+)');
    String? categoryMatch =
        categoryRegex.firstMatch(licenseText)?.group(1)?.trim();

    //extracting DL No.
    // Extracting DL No. with a more flexible regex
    // Extracting DL No. or License Number with a more flexible regex
    RegExp dlNoRegex =
        RegExp(r'(DLNo|License Number):\s*([\w\d.-]+)', caseSensitive: false);
    String? dlNoMatch = dlNoRegex.firstMatch(licenseText)?.group(2)?.trim();

    // RegExp DLRegex = RegExp(r'DLNo: (\S+)');
    // String? dlNoMatch = DLRegex.firstMatch(licenseText)?.group(1)?.trim();

    // Store key-value pairs in the map
    TextFromLicense['Name'] = nameMatch ?? '';
    TextFromLicense['Date of Birth'] = dobMatch ?? '';
    TextFromLicense['Citizenship No.'] = citizenshipNoMatch ?? '';
    TextFromLicense['Category'] = categoryMatch ?? '';
    TextFromLicense['DL No.'] = dlNoMatch ?? '';

    print(TextFromLicense.entries);

    return TextFromLicense;
  }
}
