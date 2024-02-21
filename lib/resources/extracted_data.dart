class ExtractedData {
  String citizenshipBack = '';
  String citizenshipFront = '';
  String license = '';

  Map<String, String> TextFromCitizenship = {};
  Map<String, String> TextFromLicense = {};

  Map<String, String> TextToMapFromCitizenship() {
    List<String> lines = citizenshipBack.split('\n');
    TextFromCitizenship['Name'] = lines
        .firstWhere((line) => line.startsWith('Full Name:'), orElse: () => '')
        .split('Full Name. ')
        .last
        .trim();

    TextFromCitizenship['Date of birth'] = lines
        .firstWhere((line) => line.startsWith('Date:'), orElse: () => '')
        .split('date of Birth (AD): ')
        .last
        .trim();

    TextFromCitizenship['Birth Place'] = lines
        .firstWhere((line) => line.startsWith('Birth'), orElse: () => '')
        .split('Birth place . ')
        .last
        .trim();

    String line = lines.firstWhere((line) => line.startsWith('Citizenship'));

    // Extract Citizenship Certificate No.
    RegExp certificateNoRegex = RegExp(r'Citizenship Certificate No\. (\S+)');
    String? certificateNoMatch = certificateNoRegex.firstMatch(line)?.group(1);

    // Extract Sex
    RegExp sexRegex = RegExp(r'Sex (\S+)');
    String? sexMatch = sexRegex.firstMatch(line)?.group(1);

    // Print the results
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
