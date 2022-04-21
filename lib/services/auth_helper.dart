// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/models/teachers_model.dart';
import 'package:notice_board/screens/auth_screens/student_login_screen.dart';

class AuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  // SignUp Method
  Future signUp(
      {required String email,
      required String password,
      bool isAdmin = false}) async {
    if (isAdmin) {
      bool isValid = TeachersModel.teachersEmail.contains(email);
      debugPrint("isValid $isValid");
      if (!isValid) {
        return "You don't have the admin access.";
      }
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('Register successfully');

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SignIn method
  Future signIn({
    required String email,
    required String password,
    bool isAdmin = false,
  }) async {
    if (isAdmin) {
      bool isValid = TeachersModel.teachersEmail.contains(email);
      debugPrint("isValid $isValid");
      if (!isValid) {
        return "You don't have the admin access.";
      }
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      debugPrint('Login successfully');

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SignOut Method
  Future signOut(context) async {
    await _auth.signOut();
    debugPrint('signout');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => StudentLoginScreen()),
        (route) => false);
  }

  Future verifyEmail({required context}) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kVioletShade,
          content: Text(
            'Verification email has been sent',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
