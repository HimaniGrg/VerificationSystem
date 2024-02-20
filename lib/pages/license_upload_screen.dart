import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:verificationsystem/app_export.dart';

class LicenseUploadScreen extends StatefulWidget {
  const LicenseUploadScreen({Key? key}) : super(key: key);

  @override
  State<LicenseUploadScreen> createState() => _LicenseUploadScreenState();
}

class _LicenseUploadScreenState extends State<LicenseUploadScreen> {
  late File _image;
  bool _isUploading = false;
  bool _isSelected = false;

  //function to take image from camera
  Future<void> takeImage() async {
    var imgCamera = await pickImage(ImageSource.camera);
    setState(() {
      _image = imgCamera;
      _isSelected = true;
    });
    uploadImage();
  }

  // function to upload image from gallery
  Future<void> selectImage() async {
    var imgGallery = await pickImage(ImageSource.gallery);
    setState(() {
      _image = imgGallery;
      _isSelected = true;
    });
    uploadImage();
  }

  //function to store the image in firestore
  Future<void> uploadImage() async {
    //check if image is selected
    if (_image != null) {
      StoreImage storeimage = StoreImage(); //instance of class StoreImage

      try {
        setState(() {
          _isUploading = true;
        });

        //save image to the firebase storage and firestore
        await storeimage.saveImage(documentType: 'license', file: _image);

        // Show a success message using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Image successfully uploaded!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.greenAccent,
          behavior: SnackBarBehavior.floating,
        ));
      } catch (e) {
        // Show an error message using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Error uploading image.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ));
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context), // method called for appbar
            body: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    margin: EdgeInsets.symmetric(
                        horizontal: 0.025 * MediaQuery.of(context).size.width),
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.06 * MediaQuery.of(context).size.width,
                        vertical: 42),
                    decoration: AppDecoration.fillOnPrimary.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder33),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      // page indicator
                      SizedBox(
                          height: 6,
                          width: 200,
                          child: AnimatedSmoothIndicator(
                              activeIndex: 1,
                              count: 6,
                              effect: ScrollingDotsEffect(
                                  spacing: 13,
                                  activeDotColor: appTheme.blue800,
                                  dotColor: appTheme.blueGray100,
                                  dotHeight: 5,
                                  dotWidth: 30))),
                      SizedBox(height: 30),

                      CustomImageView(
                        imagePath: ImageConstant.imgLicenseIcon,
                        height: 160,
                        width: 200,
                        alignment: Alignment.center,
                      ),
                      SizedBox(height: 30),

                      Container(
                          width: 273,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 9, right: 16),
                          child: Text("Upload your driving license",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleLarge)),

                      SizedBox(height: 15),

                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 247,
                              //margin: EdgeInsets.only(right: 51),
                              child: Text(
                                  "Upload the clear image of your driving license.",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge))),
                      SizedBox(height: 35),

                      _buildDottedbox(
                          context), //method called for customized dotted box widget

                      SizedBox(height: 20),

                      SizedBox(height: 20),

                      CustomElevatedButton(
                        alignment: Alignment.center,
                        height: 48,
                        width: 250,
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
                        buttonTextStyle: CustomTextStyles.bodyLargeOnPrimary,
                        onPressed: () {
                          takeImage();
                        },
                      ),

                      SizedBox(height: 50),
                      CustomElevatedButton(
                          text: "Next",
                          isDisabled: _isUploading,
                          //margin: EdgeInsets.symmetric(horizontal: 7),'
                          onPressed: _isUploading
                              ? null
                              : () {
                                  //disable the button while uploading
                                  onTapNext(context);
                                }),
                      //SizedBox(height: 5)
                    ])))));
  }

  /// Section Widget for App Bar
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
          // print("dotted bordered box tapped");
          selectImage();
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

  // Navigates to the selectionPageScreen when the action is triggered.
  void onTapNext(BuildContext context) {
    if (_isSelected) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DocumentUpload1Screen()));
    } else {
      // Show a message indicating that no image is selected
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Image is not selected!",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.fixed,
      ));
    }
  }
}
