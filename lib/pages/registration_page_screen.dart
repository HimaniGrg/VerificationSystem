import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:verificationsystem/app_export.dart';
import 'package:verificationsystem/auth/register_auth.dart';

class RegistrationPageScreen extends StatefulWidget {
  const RegistrationPageScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationPageScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegistrationPageScreen> {
  final TextEditingController phoneController = TextEditingController();
  String phoneNumber = "";

  Country selectedCountry = Country(
    phoneCode: "977",
    countryCode: "NP",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Nepal",
    example: "Nepal",
    displayName: "Nepal",
    displayNameNoCountryCode: "NP",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register Now',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge),
              SizedBox(
                height: 50,
              ),
              Text(
                'You need to register your phone number before getting started!',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                child: TextFormField(
                  cursorColor: Color.fromARGB(255, 4, 144, 244),
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  maxLength: 10, // maximun length of phone number
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: "Enter phone number",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: Colors.grey.shade600),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 550,
                              ),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              });
                        },
                        child: Text(
                          "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}", // display flag and country code of the selected country
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: 350,
                child: CustomElevatedButton(
                  text: "Send OTP",
                  //usage of _registerauth.phoneAuthentication
                  onPressed: () {
                    // check if the phone number and country code is filled
                    if (phoneController.text.isNotEmpty &&
                        phoneController.length == 10) {
                      print(
                          '+${selectedCountry.phoneCode}${phoneController.text}');
                      phoneNumber =
                          '+${selectedCountry.phoneCode}${phoneController.text}';

                      RegisterAuth.sendOTP(
                          phone: phoneNumber,
                          errorStep: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  "Error while sending OTP",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              )),
                          nextStep: () => onTap(context));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: const Text(
                                'Please fill in the phone number and country code.'),
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
                  //child: Text('Send OTP'),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  onTap(BuildContext context) async {
    Navigator.pushNamed(context, AppRoutes.otpPageScreen);
  }
}
