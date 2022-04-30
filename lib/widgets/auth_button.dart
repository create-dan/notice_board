// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notice_board/models/user_model.dart';

import '../helpers/constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.size,
    required this.name,
    required this.onTap,
    required this.isAdmin,
  }) : super(key: key);

  final Size size;
  final String name;
  final Function onTap;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    print("Status $isAdmin");
    Color mainColor = isAdmin ? kOrangeShade : kVioletShade;

    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
