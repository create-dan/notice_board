// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/screens/tp/upload_notice_image_screen.dart';
import 'package:notice_board/widgets/auth_button.dart';

class UploadNoticeScreen extends StatefulWidget {
  const UploadNoticeScreen({Key? key}) : super(key: key);

  @override
  State<UploadNoticeScreen> createState() => _UploadNoticeScreenState();
}

class _UploadNoticeScreenState extends State<UploadNoticeScreen> {
  String? selectedNoticeType;
  String? selectedSubject;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UploadTextField(
                          lines: 1,
                          hint: "Title",
                          controller: _titleController,
                        ),
                        SizedBox(height: 15),
                        UploadTextField(
                          lines: 7,
                          hint: 'Description',
                          controller: _descriptionController,
                        ),
                        SizedBox(height: 15),
                        // UploadTextField(
                        //   lines: 1,
                        //   hint: 'Subject',
                        //   controller: _subjectController,
                        // ),
                        Text(
                          "Notice Type",
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
                          "Notice Type",
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
                              setState(() {
                                _descriptionController.notifyListeners();

                                NoticeModel.title = _titleController.value.text;
                                NoticeModel.description =
                                    _descriptionController.value.text;
                                NoticeModel.subject = selectedSubject;
                                NoticeModel.noticeType = selectedNoticeType;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UploadNoticeImageScreen(),
                                ),
                              );
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
  }) : super(key: key);

  final int lines;
  final String hint;
  final TextEditingController controller;

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
          minLines: lines,
          maxLines: lines,
          controller: controller,
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
