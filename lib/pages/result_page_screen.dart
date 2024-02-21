import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:verificationsystem/app_export.dart';

class ResultPageScreen extends StatelessWidget {
  const ResultPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                //width: 345,
                margin: EdgeInsets.fromLTRB(7, 1, 7, 9),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 42),
                decoration: AppDecoration.fillOnPrimary
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder33),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                      height: 6,
                      child: AnimatedSmoothIndicator(
                          activeIndex: 5,
                          count: 6,
                          effect: ScrollingDotsEffect(
                              spacing: 13,
                              activeDotColor: appTheme.blue800,
                              dotColor: appTheme.blueGray100,
                              dotHeight: 5,
                              dotWidth: 25))),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          //width: 184,
                          margin: EdgeInsets.only(left: 16),
                          child: Text("Verification Result",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleLarge))),
                  SizedBox(height: 29),
                  _buildVerificationSection(context),
                  SizedBox(height: 33),
                  CustomElevatedButton(
                      text: "Save result",
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      onPressed: () {
                        onTapSaveResult(context);
                      }),
                  SizedBox(height: 19),
                  CustomElevatedButton(
                      text: "Go Back to Dashboard",
                      margin: EdgeInsets.symmetric(horizontal: 5)),
                  SizedBox(height: 5)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Verification',
      leadingIcon: Icons.dashboard,
      trailingIcon: Icons.person_rounded,
      automaticallyImplyLeading: true,
    );
  }

  /// Section Widget
  Widget _buildVerificationSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 36),
        decoration: AppDecoration.fillBlueGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder42),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomImageView(
              imagePath: ImageConstant.imageNotFound,
              height: 60,
              width: 60,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 91)),
          SizedBox(height: 10),
          SizedBox(
              width: 71,
              child: Text("Verified !",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium)),
          SizedBox(height: 25),
          SizedBox(
              width: 250,
              child: Text(
                  "Your documents are verified !\nInformation of your documents matches.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge)),
          SizedBox(height: 41)
        ]));
  }

  /// Navigates to the licenseUploadScreen when the action is triggered.
  onTapSaveResult(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.licenseUploadScreen);
  }
}
