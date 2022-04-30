// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.name,
    this.validator,
    this.textInputAction = TextInputAction.next,
    required this.controller,
    required this.icon,
    this.isAdmin = false,
  }) : super(key: key);

  final String name;
  final FormFieldValidator? validator;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final IconData icon;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    Color myColor = isAdmin ? kOrangeShade : kVioletShade;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        Stack(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: isAdmin
                    ? kOrangeShade.withOpacity(0.2)
                    : kVioletShade.withOpacity(0.2),
                border: Border.all(
                  color: Colors.grey.shade400.withOpacity(0.15),
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                  selectionColor: myColor,
                  cursorColor: myColor,
                  selectionHandleColor: myColor,
                ),
              ),
              child: TextFormField(
                validator: validator,
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 18),
                cursorColor: myColor,
                textInputAction: textInputAction,
                decoration: InputDecoration(
                  hintText: name,
                  // contentPadding: EdgeInsets.symmetric(horizontal: 32),
                  prefixIcon: Icon(icon, color: myColor),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
