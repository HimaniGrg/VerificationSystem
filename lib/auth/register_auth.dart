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
      timeout: const Duration(seconds: 30),
      //callback to handle SMS
      verificationCompleted: (phoneAuthCredential) async {
        return;
      },
      //handle if there is any error
      verificationFailed: (error) async {
        return;
      },
      // handle when otp is send to device from Firebase
      codeSent: (verificationId, forceResendingToken) async {
        verifyId = verificationId;
        nextStep();
      },
      // handle timeout
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        //if in case error occurs
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  //function to verify OTP and login
  static Future loginWithOTP({required String otp}) async {
    final cred = PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode:
            otp); //verifyId => code send by system and otp => code user enter

    try {
      final user = await _auth.signInWithCredential(cred);
      //check if user is signed in or not
      if (user.user != null) {
        return "Sucsess";
      } else {
        return "error while login with otp";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
    //exception except firebase
    catch (e) {
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
    return user != null; // if there is user it return true else false
  }
}
