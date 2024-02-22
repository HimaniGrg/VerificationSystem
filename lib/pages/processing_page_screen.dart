import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:verificationsystem/app_export.dart';
import 'package:verificationsystem/resources/extracted_data.dart';

class ProcessingPageScreen extends StatefulWidget {
  const ProcessingPageScreen({super.key});
  @override
  State<ProcessingPageScreen> createState() => _ProcessingPageScreenState();
}

class _ProcessingPageScreenState extends State<ProcessingPageScreen> {
  // add a variable to track whether a data is being loaded

  TextExtraction textExtraction = TextExtraction();
  late Future<Map<String, String>> extractedData;

  @override
  void initState() {
    super.initState();
    //call the function to fetch image URLS when screen initializes
    try {
      // Call extractText to get the extracted data and assign it to extractedData
      extractedData = textExtraction.extractText();
    } catch (err) {
      print("Error extracting text from images: $err");
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
            body: SingleChildScrollView(
              child: FutureBuilder<Map<String, String>>(
                future: extractedData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // Handle error state
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    // Access and display the extracted data
                    Map<String, String> data = snapshot.data!;
                    ExtractedData details = ExtractedData();
                    details.citizenshipBack = data['citizenship_back']!;
                    details.citizenshipFront = data['citizenship_front']!;
                    details.license = data['license']!;
                    // print(
                    //     "${details.citizenshipBack} \n Citizenship_front: ${details.citizenshipFront} \n License: ${details.license}");
                    details.TextToMapFromCitizenship();
                    return SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                0.025 * MediaQuery.of(context).size.width),
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                0.06 * MediaQuery.of(context).size.width,
                            vertical: 42),
                        decoration: AppDecoration.fillOnPrimary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder33),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // page indicator
                              SizedBox(
                                  height: 6,
                                  width: 200,
                                  child: AnimatedSmoothIndicator(
                                      activeIndex: 4,
                                      count: 6,
                                      effect: ScrollingDotsEffect(
                                          spacing: 13,
                                          activeDotColor: appTheme.blue800,
                                          dotColor: appTheme.blueGray100,
                                          dotHeight: 5,
                                          dotWidth: 30))),
                              SizedBox(height: 30),
                              Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                    Text(
                                      'Extracted Information',
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Your documents are verified based on these extracted data.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ])),
                              SizedBox(height: 20),
                              Row(children: [
                                Container(
                                  height: 150,
                                  width: 120,
                                  color: Colors.grey[300],
                                  child: textExtraction.imageUrls['license'] ==
                                          null
                                      ? Icon(
                                          Icons.image,
                                          size: 100,
                                          color: Colors
                                              .red, // Add a color for visibility
                                        )
                                      : Image.network(
                                          textExtraction.imageUrls['license']!,
                                          height: 300,
                                          width: 300,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                SizedBox(width: 10),
                                // Display text on the right side
                                Container(
                                  child: Text(
                                    '${data['license']}',
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                )
                              ]),
                              SizedBox(height: 10),
                              // Row(children: [
                              //   Container(
                              //     height: 150,
                              //     width: 120,
                              //     color: Colors.grey[300],
                              //     child: textExtraction
                              //                 .imageUrls['citizenship_front'] ==
                              //             null
                              //         ? Icon(
                              //             Icons.image,
                              //             size: 100,
                              //             color: Colors
                              //                 .red, // Add a color for visibility
                              //           )
                              //         : Image.network(
                              //             textExtraction
                              //                 .imageUrls['citizenship_front']!,
                              //             height: 300,
                              //             width: 300,
                              //             fit: BoxFit.fill,
                              //           ),
                              //   ),
                              //   SizedBox(width: 10),
                              //   // Display text on the right side
                              //   Container(
                              //     child: Text(
                              //       '${data['citizenship_front']}',
                              //       maxLines: 6,
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           fontSize: 16, color: Colors.black),
                              //     ),
                              //   )
                              // ]),
                              const SizedBox(height: 10),

                              Row(children: [
                                Container(
                                  height: 150,
                                  width: 120,
                                  color: Colors.grey[300],
                                  child: textExtraction
                                              .imageUrls['citizenship_back'] ==
                                          null
                                      ? Icon(
                                          Icons.image,
                                          size: 100,
                                          color: Colors
                                              .red, // Add a color for visibility
                                        )
                                      : Image.network(
                                          textExtraction
                                              .imageUrls['citizenship_back']!,
                                          height: 300,
                                          width: 300,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                SizedBox(width: 10),
                                // Display text on the right side
                                Container(
                                  child:
                                      // Display extracted data
                                      Text(
                                    "Name: ${details.TextFromCitizenship['Name']}\nSex: ${details.TextFromCitizenship['Sex']}\nDOB: ${details.TextFromCitizenship['Date of Birth']}\nCitizenship No.: \n${details.TextFromCitizenship['Citizenship No.']}",
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                )
                              ]),
                              const SizedBox(height: 50),

                              Container(
                                height: 50,
                                // width: 150,
                                child: CustomElevatedButtonIndicator(
                                    alignment: Alignment.center,
                                    text: "Verify",
                                    height: 50,
                                    onPressed: () {
                                      //disable the button while uploading
                                      onTapNext(context);
                                    }),
                              )
                            ]),
                      ),
                    );
                  } else {
                    // Handle loading state
                    return AlertDialog(
                      content: Container(
                        margin: EdgeInsets.only(top: 50),
                        height: 500,
                        width: 300, // Adjust the height as needed
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: 3,
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blueAccent),
                                strokeWidth: 2,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(height: 60),
                            Text(
                              'Processing',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            )));
  }

  /// Section Widget for App Bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Extraction Result',
      leadingIcon: Icons.dashboard,
      trailingIcon: Icons.person_rounded,
      automaticallyImplyLeading: false,
    );
  }

  /// Navigates to the documentUpload1Screen when the action is triggered.
  onTapCancel(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.resultPageScreen);
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

  void onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.processingPageScreen);
  }
}
