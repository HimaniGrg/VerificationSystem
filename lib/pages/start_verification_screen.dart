import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:verificationsystem/app_export.dart';

class StartVerificationScreen extends StatelessWidget {
  const StartVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                //width: 345,
                margin: EdgeInsets.fromLTRB(7, 1, 7, 9),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 42),
                decoration: AppDecoration.fillOnPrimary
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder33),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                      height: 10,
                      width: 200,
                      child: AnimatedSmoothIndicator(
                          activeIndex: 0,
                          count: 6,
                          effect: ScrollingDotsEffect(
                              spacing: 13,
                              activeDotColor: appTheme.blue800,
                              dotColor: appTheme.blueGray100,
                              dotHeight: 5,
                              dotWidth: 30))),
                  SizedBox(
                    height: 50,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.verificationIcon,
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 30),
                  Container(
                      width: 220,
                      margin: EdgeInsets.only(left: 44, right: 48),
                      alignment: Alignment.center,
                      child: Text("Start your verification",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge)),
                  SizedBox(height: 13),
                  Container(
                      width: 288,
                      margin: EdgeInsets.only(left: 8, right: 17),
                      child: Text(
                          "We need to determine if the driving license is authentic and belongs to you.",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge)),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: 284,
                          margin: EdgeInsets.only(left: 8, right: 17),
                          child: Text(
                              "Make sure you have following document at hand. The process will just take a few minutes.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge))),
                  SizedBox(height: 60),
                  CustomElevatedButton(
                      text: "Start",
                      onPressed: () {
                        onTapStart(context);
                      }),
                  SizedBox(height: 60)
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

  /// Navigates to the licenseUploadScreen when the action is triggered.
  onTapStart(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.licenseUploadScreen);
  }
}
