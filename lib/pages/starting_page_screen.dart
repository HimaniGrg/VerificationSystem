import 'package:flutter/material.dart';
import 'package:verificationsystem/app_export.dart';

class StartingPageScreen extends StatelessWidget {
  const StartingPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: theme.colorScheme.onPrimary.withOpacity(1),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 192),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 45),
                      CustomImageView(
                          imagePath: ImageConstant.appIcon,
                          height: 106,
                          width: 106),
                      SizedBox(height: 20),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 270,
                              margin: EdgeInsets.only(left: 50),
                              child: Text("Fast . Trustworthy . Reliable",
                                  style: CustomTextStyles.bodyLargeKantumruy))),
                      Spacer(flex: 54),
                      CustomElevatedButton(
                          text: "Get Started",
                          margin: EdgeInsets.only(left: 11),
                          onPressed: () {
                            onTapGetStarted(context);
                          })
                    ]))));
  }

  /// Navigates to the registrationPageScreen when the action is triggered.
  onTapGetStarted(BuildContext context) {
    AppRoutes.pushReplacement(context, AppRoutes.registrationPageScreen);
  }
}
