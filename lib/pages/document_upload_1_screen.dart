import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:verificationsystem/app_export.dart';

class DocumentUpload1Screen extends StatelessWidget {
  const DocumentUpload1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context), // method called for appbar
            body: Container(
                //width: 345,
                margin: EdgeInsets.fromLTRB(7, 1, 7, 9),
                padding: EdgeInsets.symmetric(horizontal: 23, vertical: 42),
                decoration: AppDecoration.fillOnPrimary
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder33),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                      height: 6,
                      child: AnimatedSmoothIndicator(
                          activeIndex: 2,
                          count: 6,
                          effect: ScrollingDotsEffect(
                              spacing: 13,
                              activeDotColor: appTheme.blue800,
                              dotColor: appTheme.blueGray100,
                              dotHeight: 5,
                              dotWidth: 30))),
                  SizedBox(height: 30),
                  CustomImageView(
                    imagePath: ImageConstant.imgCitizenshipIcon,
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                    //margin: EdgeInsets.only(left: 60)
                  ),
                  SizedBox(height: 28),
                  Container(
                      width: 273,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 9, right: 16),
                      child: Text("Upload your citizenship",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge)),
                  SizedBox(height: 12),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: 247,
                          //margin: EdgeInsets.only(right: 51),
                          child: Text(
                              "Upload the clear image of your citizenship (front face).",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge))),
                  SizedBox(height: 35),
                  _buildDottedbox(
                      context), //method called for customized dotted box widget
                  SizedBox(height: 40),
                  CustomElevatedButton(
                      alignment: Alignment.center,
                      height: 48,
                      width: 200,
                      text: "Take a picture",
                      leftIcon: Container(
                          margin: EdgeInsets.only(left: 2, right: 5),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgBasilcameraoutline,
                            height: 32,
                            width: 32,
                            color: Colors.white,
                          )),
                      buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                      buttonTextStyle: CustomTextStyles.bodyLargeOnPrimary),
                  SizedBox(height: 50),
                  CustomElevatedButton(
                      text: "Next",
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      onPressed: () {
                        onTapNext(context);
                      }),
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
  Widget _buildDottedbox(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("dotted bordered box tapped");
        },
        child: Container(
            alignment: Alignment.center,
            width: 300,
            margin: EdgeInsets.only(left: 2, right: 1),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: AppDecoration.fillBlueGray
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 1),
                  Container(
                      margin: EdgeInsets.only(left: 1),
                      decoration: AppDecoration.outlineBlack.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder10),
                      child: DottedBorder(
                          color: appTheme.black900.withOpacity(0.5),
                          padding: EdgeInsets.only(
                              left: 1, top: 1, right: 1, bottom: 1),
                          strokeWidth: 1,
                          radius: Radius.circular(10),
                          borderType: BorderType.RRect,
                          dashPattern: [3, 3],
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 27, vertical: 12),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomImageView(
                                        imagePath:
                                            ImageConstant.imgSolarGalleryLinear,
                                        height: 30,
                                        width: 30,
                                        color: Colors.blueAccent,
                                        margin: EdgeInsets.only(bottom: 3)),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 5, bottom: 7, left: 25),
                                        child: Text(
                                          "Select from a gallery",
                                          style: theme.textTheme.bodyLarge,
                                        ))
                                  ]))))
                ])));
  }

  /// Navigates to the selectionPageScreen when the action is triggered.
  onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.documentUpload2Screen);
  }
}
