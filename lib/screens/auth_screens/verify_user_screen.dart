// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/screens/home_page.dart';
import '../../services/auth_helper.dart';

class VerifyUserScreen extends StatefulWidget {
  const VerifyUserScreen({Key? key}) : super(key: key);

  @override
  _VerifyUserScreenState createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  bool isAdmin = UserModel.isAdmin;
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  User? user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;

    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      AuthHelper().verifyEmail(context: context);

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: isAdmin ? kOrangeShade : kVioletShade,
          content: Text(
            'Email verified Successfully',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? HomePage()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Verify Email',
                style: TextStyle(fontSize: 22),
              ),
              backgroundColor: isAdmin ? Colors.orangeAccent : kVioletShade,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'A verification email has been send on ${user!.email}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      AuthHelper().verifyEmail(context: context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isAdmin ? kOrangeShade : kVioletShade,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Resend Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      await AuthHelper().signOut(context: context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isAdmin ? kOrangeShade : kVioletShade),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isAdmin ? kOrangeShade : kVioletShade,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
