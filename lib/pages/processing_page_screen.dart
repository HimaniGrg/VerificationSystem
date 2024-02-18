import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:verificationsystem/app_export.dart';

class ProcessingPageScreen extends StatelessWidget {
  const ProcessingPageScreen({Key? key}) : super(key: key);

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
                          activeIndex: 4,
                          count: 6,
                          effect: ScrollingDotsEffect(
                              spacing: 13,
                              activeDotColor: appTheme.blue800,
                              dotColor: appTheme.blueGray100,
                              dotHeight: 5,
                              dotWidth: 25))),
                  SizedBox(height: 30),
                  Spacer(flex: 49),
                  _buildProcessingPageThree(context),
                  Spacer(flex: 50)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Verification',
      leadingIcon: Icons.dashboard,
      trailingIcon: Icons.person_rounded,
    );
  }

  /// Section Widget
  Widget _buildProcessingPageThree(BuildContext context) {
    return Container(
        //width: 295,
        padding: EdgeInsets.symmetric(horizontal: 29, vertical: 39),
        decoration: AppDecoration.fillBlueGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder42),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 122,
                  //width: 217,
                  child: Stack(alignment: Alignment.center, children: [
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            width: 95,
                            margin: EdgeInsets.only(right: 80),
                            child: Text("Processing !",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium))),
                    CustomImageView(
                        imagePath: ImageConstant.imgCarbonProgressBar,
                        height: 119,
                        width: 217,
                        alignment: Alignment.center)
                  ])),
              SizedBox(height: 22),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 213,
                      margin: EdgeInsets.symmetric(horizontal: 11),
                      child: Text("Your documents are being processed.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge))),
              SizedBox(height: 50),
              CustomElevatedButton(
                  text: "Cancel",
                  margin: EdgeInsets.only(left: 30, right: 41),
                  onPressed: () {
                    onTapCancel(context);
                  }),
              SizedBox(height: 9)
            ]));
  }

  /// Navigates to the documentUpload1Screen when the action is triggered.
  onTapCancel(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.resultPageScreen);
  }
}
