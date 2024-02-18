import 'package:firebase_auth/firebase_auth.dart';

class RegisterAuth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String verifyId = "";

  // function to send an OTP
  static Future sendOTP({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    await _auth
        .verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 30),
      verificationCompleted: (phoneAuthCredential) async {
        return;
      },
      verificationFailed: (error) async {
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        verifyId = verificationId;
        nextStep();
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  //function to verify OTP
  static Future loginWithOTP({required String otp}) async {
    final cred = PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode:
            otp); //verifyId => code send by system and otp => code user enter

    try {
      final user = await _auth.signInWithCredential(cred);
      if (user.user != null) {
        return "Sucsess";
      } else {
        return "error while login with otp";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //function to log out user
  static Future logOut() async {
    await _auth.signOut();
  }

  //check whether user is logged in or not
  static Future<bool> isLoggedIn() async {
    var user = _auth.currentUser;
    return user != null;
  }
}
