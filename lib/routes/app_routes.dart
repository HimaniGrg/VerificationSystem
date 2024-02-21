import 'package:flutter/material.dart';
import 'package:verificationsystem/app_export.dart';

class AppRoutes {
  static const String startingPageScreen = '/starting_page_screen';

  static const String registrationPageScreen = '/registration_page_screen';

  static const String otpPageScreen = '/otp_page_screen';

  static const String dashboardPageScreen = '/dashboard_page_screen';

  static const String startVerificationScreen = '/start_verification_screen';

  static const String licenseUploadScreen = '/license_upload_screen';

  static const String documentUpload1Screen = '/document_upload_1_screen';

  static const String documentUpload2Screen = '/document_upload_2_screen';

  static const String processingPageScreen = '/processing_page_screen';

  static const String extractionResultScreen = '/extraction_result_screen';

  static const String resultPageScreen = '/result_page_screen';

  static Map<String, WidgetBuilder> routes = {
    startingPageScreen: (context) => const StartingPageScreen(),
    registrationPageScreen: (context) => const RegistrationPageScreen(),
    otpPageScreen: (context) => const OtpPageScreen(),
    dashboardPageScreen: (context) => const DashboardPageScreen(),
    startVerificationScreen: (context) => const StartVerificationScreen(),
    licenseUploadScreen: (context) => const LicenseUploadScreen(),
    documentUpload1Screen: (context) => const DocumentUpload1Screen(),
    documentUpload2Screen: (context) => const DocumentUpload2Screen(),
    processingPageScreen: (context) => const ProcessingPageScreen(),
    resultPageScreen: (context) => const ResultPageScreen()
  };

  // function for replace navigation
  static void pushReplacement(BuildContext context, String routeName) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: routes[routeName]!));
  }
}
