import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:verificationsystem/app_export.dart';

class ResultPageScreen extends StatefulWidget {
  final double? similarityPercentage;

  const ResultPageScreen({Key? key, required this.similarityPercentage})
      : super(key: key);

  @override
  State<ResultPageScreen> createState() => _ResultPageScreenState();
}

class _ResultPageScreenState extends State<ResultPageScreen> {
  late IconData resultIcon;
  late Color resultColor;
  late String resultMessage;
  late double similarityPercentage;

  @override
  void initState() {
    super.initState();

    similarityPercentage =
        widget.similarityPercentage ?? 0.0; // Default to 0 if null
    print(similarityPercentage);

    if (similarityPercentage >= 80) {
      resultIcon = Icons.check_circle;
      resultColor = Colors.green;
      resultMessage = 'Verification Successful!';
    } else {
      resultIcon = Icons.cancel;
      resultColor = Colors.red;
      resultMessage = 'Verification Failed!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final double? percentage = arguments?['percentage'] as double?;
    return Scaffold(
        appBar: _buildAppBar(context), // method called for appbar
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              margin: EdgeInsets.symmetric(
                  horizontal: 0.025 * MediaQuery.of(context).size.width),
              padding: EdgeInsets.symmetric(
                  horizontal: 0.06 * MediaQuery.of(context).size.width,
                  vertical: 42),
              decoration: AppDecoration.fillOnPrimary
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder33),
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
                            activeIndex: 5,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Verification Result',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 30),
                            Icon(resultIcon, color: resultColor, size: 100),
                            SizedBox(height: 20),
                            Text(
                              resultMessage,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Similarity Percentage: ${percentage!.toStringAsFixed(2)}%',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            const SizedBox(height: 50),
                            Container(
                              height: 50,
                              // width: 150,
                              child: CustomElevatedButton(
                                  alignment: Alignment.center,
                                  text: "Save Result",
                                  height: 50,
                                  onPressed: () {
                                    //disable the button while uploading
                                    onTapSaveResult(context);
                                  }),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 50,
                              // width: 150,
                              child: CustomElevatedButton(
                                  alignment: Alignment.center,
                                  text: "Go Back To Dashbord",
                                  height: 50,
                                  onPressed: () {
                                    //disable the button while uploading
                                    onTapGoToDashboard(context);
                                  }),
                            )
                          ]),
                    ),
                  ]),
            ),
          ),
        ));
  }

  /// Section Widget for App Bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Verification Result',
      leadingIcon: Icons.dashboard,
      trailingIcon: Icons.person_rounded,
      automaticallyImplyLeading: false,
    );
  }

  void onTapGoToDashboard(BuildContext context) {
    AppRoutes.pushReplacement(context, AppRoutes.dashboardPageScreen);
  }

  void onTapSaveResult(BuildContext) {
    // go to saved files page inside user profile inside dashboard
    AppRoutes.pushReplacement(context, AppRoutes.dashboardPageScreen);
  }
}
