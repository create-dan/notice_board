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
    this.status = false,
  }) : super(key: key);

  final String name;
  final FormFieldValidator? validator;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final IconData icon;
  final bool status;

  @override
  Widget build(BuildContext context) {
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
                color: status
                    ? kOrangeShade.withOpacity(0.2)
                    : kVioletShade.withOpacity(0.2),
                border: Border.all(
                  color: Colors.grey.shade400.withOpacity(0.15),
                ),
              ),
            ),
            TextFormField(
              validator: validator,
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 18),
              cursorColor: status ? kOrangeShade : kVioletShade,
              textInputAction: textInputAction,
              decoration: InputDecoration(
                hintText: name,
                // contentPadding: EdgeInsets.symmetric(horizontal: 32),
                prefixIcon:
                    Icon(icon, color: status ? kOrangeShade : kVioletShade),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
