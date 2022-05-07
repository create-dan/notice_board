// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notice_board/screens/tp/all_notices.dart';
import 'package:notice_board/screens/tp/upload_notice_screen.dart';
import 'package:notice_board/screens/tp/user_profile.dart';
import 'package:notice_board/widgets/auth_button.dart';

class TpScreen extends StatelessWidget {
  const TpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthButton(
              size: size,
              name: "Profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(),
                  ),
                );
              },
              isAdmin: true,
            ),
            SizedBox(height: 30),
            AuthButton(
              size: size,
              name: "Create Notice",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadNoticeScreen(),
                  ),
                );
              },
              isAdmin: true,
            ),
            SizedBox(height: 30),
            AuthButton(
              size: size,
              name: "All Notices",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllNotices(),
                  ),
                );
              },
              isAdmin: true,
            ),
            SizedBox(height: 30),
            AuthButton(
              size: size,
              name: "My Notices",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllNotices(),
                  ),
                );
              },
              isAdmin: true,
            ),
          ],
        ),
      ),
    );
  }
}
