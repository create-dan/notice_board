// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notice_board/models/user_model.dart';

const kPrimaryColor = Color(0xff010440);
const kVioletShade = Color(0xff9085E8);
const Color kGreenShadeColor = Color(0xff05C764);
const Color kLightBlueShadeColor = Color(0xff60EEFB);
const kOrangeShade = Color(0xffFFB74D);
const kHeroTag1 = "profile";

var kTextFormFieldAuthDec = InputDecoration(
  contentPadding: EdgeInsets.only(top: 18, bottom: 18),
  hintStyle: TextStyle(color: Colors.grey.shade700),
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  errorStyle: TextStyle(color: kGreenShadeColor),
);

Color mainColor = UserModel.isAdmin ? kOrangeShade : kVioletShade;

var kInputDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: mainColor),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: mainColor),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: mainColor),
  ),
);

final academicYears = ["First Year", "Second Year", "Third Year", "Final Year"];

final branches = [
  "Computer Science",
  "Information Technology",
  "Electronics",
  "Electrical",
  "Mechanical",
  "Civil"
];

final clubs = ["ACSES", "SAIT", "ELESA", "EESA", "MESA", "CESA"];
final category = [
  "Dean",
  "Principal",
  "H.O.D.",
  "Class Teacher",
  "Class Representative"
];

final noticeType = ["General", "Exam", "Lecture", "Assignment"];
