// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/widgets/auth_button.dart';
import 'package:notice_board/screens/auth_screens/student_login_screen.dart';
import 'package:notice_board/screens/auth_screens/teacher_login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthButton(
              size: size,
              name: "Students",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentLoginScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            AuthButton(
              color: kOrangeShade,
              size: size,
              name: "Admins",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeacherLoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
