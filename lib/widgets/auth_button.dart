// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.size,
    required this.name,
    required this.onTap,
    this.status = false,
    this.color = kVioletShade,
  }) : super(key: key);

  final Size size;
  final String name;
  final Function onTap;
  final bool status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: status ? kOrangeShade : color,
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
