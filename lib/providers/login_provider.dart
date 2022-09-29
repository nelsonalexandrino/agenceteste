import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider(this.instance);

  final FirebaseAuth instance;

  Future<bool> signWithGoogle() async {
    try {
      GoogleSignInAccount? user = await GoogleSignIn().signIn();

      if (user != null) {
        var authentication = await user.authentication;

        if (authentication.idToken != null &&
            authentication.accessToken != null) {
          var credential = GoogleAuthProvider.credential(
            accessToken: authentication.accessToken,
            idToken: authentication.idToken,
          );
          var userCredential = await instance.signInWithCredential(credential);

          if (userCredential.user != null) {
            return true;
          }
        }
      } else {
        return false;
      }
    } on PlatformException catch (error) {
      debugPrint(error.toString());
      return false;
    }

    return false;
  }

  Future<bool> signWithFacebook() async {
    try {
      LoginResult result = await FacebookAuth.instance.login();

      if (result.accessToken != null) {
        var credential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        instance.signInWithCredential(credential);

        return true;
      } else {
        return false;
      }
    } on PlatformException catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    instance.signOut();
    return true;
  }
}
