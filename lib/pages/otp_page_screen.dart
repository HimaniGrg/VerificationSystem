import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:verificationsystem/app_export.dart';

class OtpPageScreen extends StatefulWidget {
  const OtpPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpPageScreen> createState() => _OtpPageScreenState();
}

class _OtpPageScreenState extends State<OtpPageScreen> {
  final TextEditingController otpController = TextEditingController();
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: [
                  Text(
                    'OTP Verification',
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Enter the OTP code received in your phone number',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    controller: otpController,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomElevatedButton(
                text: "Submit OTP",
                onPressed: () {
                  // check if otp is entered or not
                  if (otpController.text.isNotEmpty &&
                      otpController.length == 6) {
                    print(otpController.text);
                    otpCode = otpController.text;
                    RegisterAuth.loginWithOTP(
                        otp: otpCode,
                        errorStep: () => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                "Invalid OTP",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            )),
                        nextStep: () => onTapSubmitOTP());
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: const Text(
                              'Please enter OTP that you received through SMS.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Didn't receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  print("Resend code tapped.");
                },
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  onTapSubmitOTP() {
    //await widget.authOperation.signInWithPhoneNumber(enteredOtp, widget.verificationId);
    Navigator.pushNamed(context, AppRoutes.dashboardPageScreen);
  }
}
