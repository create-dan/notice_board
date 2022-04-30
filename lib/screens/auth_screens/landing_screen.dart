// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notice_board/models/user_model.dart';
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
              isAdmin: UserModel.isAdmin,
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
              size: size,
              name: "Admins",
              isAdmin: true,
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
