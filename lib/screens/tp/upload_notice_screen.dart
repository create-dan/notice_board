// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/helpers/validators.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/screens/tp/upload_notice_image_screen.dart';
import 'package:notice_board/widgets/auth_button.dart';

class UploadNoticeScreen extends StatefulWidget {
  const UploadNoticeScreen({Key? key}) : super(key: key);

  @override
  State<UploadNoticeScreen> createState() => _UploadNoticeScreenState();
}

class _UploadNoticeScreenState extends State<UploadNoticeScreen> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  String? selectedNoticeType;
  String? selectedSubject;
  String? selectedYear;
  String? selectedBranch;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final condition = NoticeModel1.noticeType == null ||
      NoticeModel1.noticeType.toString() == "" ||
      NoticeModel1.branch == null ||
      NoticeModel1.branch.toString() == "" ||
      NoticeModel1.year == null ||
      NoticeModel1.year.toString() == "" ||
      NoticeModel1.subject == null ||
      NoticeModel1.subject.toString() == "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    DropdownMenuItem<String> buildNoticeTypeCategory(String category) =>
        DropdownMenuItem(
          value: category,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(category),
          ),
        );

    DropdownMenuItem<String> buildSubjectCategory(String subject) =>
        DropdownMenuItem(
          value: subject,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(subject),
          ),
        );

    DropdownMenuItem<String> buildYearCategory(String year) => DropdownMenuItem(
          value: year,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(year),
          ),
        );

    DropdownMenuItem<String> buildBranchCategory(String branch) =>
        DropdownMenuItem(
          value: branch,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(branch),
          ),
        );

    return Scaffold(
      appBar: AppBar(backgroundColor: kOrangeShade),
      body: Column(
        children: [
          SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            // height: size.height * 0.2,
            child: Text(
              "Fill the details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                    // border: Border.all(color: kOrangeShade, width: 2),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: _formFieldKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UploadTextField(
                            lines: 1,
                            hint: "Title*",
                            controller: _titleController,
                            validator: myValidator(requiredField: "Title"),
                          ),
                          SizedBox(height: 15),
                          UploadTextField(
                            lines: 7,
                            hint: 'Description',
                            controller: _descriptionController,
                            validator: (value) {
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Year*",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: kOrangeShade, width: 2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Choose Year"),
                                ),
                                isExpanded: true,
                                items: year.map(buildYearCategory).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedYear = value;
                                  });
                                },
                                value: selectedYear,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Branch*",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: kOrangeShade, width: 2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Choose Branch"),
                                ),
                                isExpanded: true,
                                items: branch.map(buildBranchCategory).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBranch = value;
                                  });
                                },
                                value: selectedBranch,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Subject*",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: kOrangeShade, width: 2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Choose Subject"),
                                ),
                                isExpanded: true,
                                items:
                                    subjects.map(buildSubjectCategory).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedSubject = value;
                                  });
                                },
                                value: selectedSubject,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Notice Type*",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: kOrangeShade, width: 2),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Choose Category"),
                                ),
                                isExpanded: true,
                                items: noticeType
                                    .map(buildNoticeTypeCategory)
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedNoticeType = value;
                                  });
                                },
                                value: selectedNoticeType,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: AuthButton(
                              size: size,
                              name: "Next",
                              onTap: () {
                                if (_formFieldKey.currentState!.validate()) {
                                  setState(() {
                                    _descriptionController.notifyListeners();

                                    NoticeModel1.title =
                                        _titleController.value.text;
                                    NoticeModel1.description =
                                        _descriptionController.value.text;
                                    NoticeModel1.subject = selectedSubject;
                                    NoticeModel1.noticeType =
                                        selectedNoticeType;
                                    NoticeModel1.owner = UserModel.name;
                                    NoticeModel1.branch = selectedBranch;
                                    NoticeModel1.branch = selectedYear;
                                  });
                                  if (condition) {
                                    return ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text(
                                          'Please fill all required field',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UploadNoticeImageScreen(),
                                      ),
                                    );
                                  }
                                }
                              },
                              isAdmin: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UploadTextField extends StatelessWidget {
  const UploadTextField({
    Key? key,
    required this.lines,
    required this.hint,
    required this.controller,
    this.validator,
    this.minLines = 1,
  }) : super(key: key);

  final int lines, minLines;
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5),
        TextFormField(
          minLines: minLines,
          maxLines: lines,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            focusColor: Colors.red,
            fillColor: Colors.red,
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: kOrangeShade, width: 2.0),
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kOrangeShade, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kOrangeShade, width: 2.0),
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
