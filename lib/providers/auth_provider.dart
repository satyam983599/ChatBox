import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '1004775718427-cnrchvde3n3ks9ken5k2enp8if7q0sp2.apps.googleusercontent.com', // Web Client ID
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  User? get user => _user;
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
// Track if it's the first login
  bool? _isFirstTimeLogin;

  bool get isFirstTimeLogin => _isFirstTimeLogin!;

  /// Manual login with Google
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return; // User canceled the sign-in
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      print(_auth.currentUser);
      _isAuthenticated = true;
      _isFirstTimeLogin = await checkUserExists(_auth.currentUser!.uid);
      _user = _auth.currentUser;
      notifyListeners();
    } catch (error) {
      print('Error during Google sign-in: $error');
    }
  }

  /// Logout from Firebase and Google
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      _user = null;
      notifyListeners();
    } catch (error) {
      print('Error during sign-out: $error');
    }
  }


  Future<bool> checkUserExists(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists;
  }

  void setUser(User user){
    _user = user;
  }

}

