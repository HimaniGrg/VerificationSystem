import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:verificationsystem/app_export.dart';

class DocumentUpload2Screen extends StatefulWidget {
  const DocumentUpload2Screen({super.key});

  @override
  State<DocumentUpload2Screen> createState() => _DocumentUpload2ScreenState();
}

class _DocumentUpload2ScreenState extends State<DocumentUpload2Screen> {
  late File _image;
  bool _isUploading = false;
  bool _isSelected = false;

  //function to take image from camera
  Future<void> takeImage() async {
    var imgCamera = await pickImage(ImageSource.camera);
    _image = imgCamera;
    setState(() {
      _isSelected = true;
    });
    uploadImage();
  }

  // function to upload image from gallery
  Future<void> selectImage() async {
    var imgGallery = await pickImage(ImageSource.gallery);
    _image = imgGallery;
    setState(() {
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
        await storeimage.uploadImagetoStorage(
            documentType: 'citizenship_back', imgfile: _image);

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
          duration: Duration(seconds: 2),
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
          duration: Duration(seconds: 2),
        ));
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
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
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return showDiscardDialog(context);
        },
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
                              "Upload the clear image of your citizenship (back face).",
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
                    buttonTextStyle: CustomTextStyles.bodyLargeOnPrimary,
                    onPressed: () => takeImage(),
                  ),
                  SizedBox(height: 50),
                  CustomElevatedButton(
                      text: "Verify",
                      isDisabled: _isUploading,
                      //margin: EdgeInsets.symmetric(horizontal: 7),'
                      onPressed: _isUploading
                          ? null
                          : () {
                              //disable the button while uploading
                              onTapNext(context);
                            }),
                ]))));
  }

  /// Section Widget for App Bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Verification',
      leadingIcon: Icons.dashboard,
      trailingIcon: Icons.person_rounded,
      automaticallyImplyLeading: false,
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

  /// Navigates to the selectionPageScreen when the action is triggered.
  onTapNext(BuildContext context) {
    //check if image is selected or not
    if (_isSelected) {
      AppRoutes.pushReplacement(context, AppRoutes.processingPageScreen);
    } else {
      // Show a Snackbar indicating that an image needs to be selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Image is not selected!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Method to show a confirmation dialog before discarding changes
  Future<bool> showDiscardDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Stop verification'),
          content:
              Text('Are you sure you want to stop the verification proccess?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Discard changes
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Stay on the screen
              },
              child: Text('No, keep verifying'),
            ),
          ],
        );
      },
    );
  }
}
