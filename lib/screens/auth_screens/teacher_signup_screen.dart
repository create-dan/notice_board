// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/models/teachers_model.dart';
import 'package:notice_board/screens/auth_screens/auth_text_field.dart';
import 'package:notice_board/screens/auth_screens/student_login_screen.dart';
import 'package:notice_board/screens/auth_screens/teacher_login_screen.dart';
import 'auth_button.dart';

class TeacherSignupScreen extends StatefulWidget {
  const TeacherSignupScreen({Key? key}) : super(key: key);

  @override
  State<TeacherSignupScreen> createState() => _TeacherSignupScreenState();
}

class _TeacherSignupScreenState extends State<TeacherSignupScreen> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (TeachersModel.teachersEmail.isNotEmpty) {
      debugPrint(TeachersModel.teachersEmail[0]);
    }

    return Scaffold(
      body: Center(
        child: Form(
          key: _formFieldKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "SignUp",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  AuthTextField(
                    status: true,
                    name: 'Name',
                    controller: emailController,
                    icon: FontAwesomeIcons.user,
                  ),
                  SizedBox(height: 20),
                  AuthTextField(
                    status: true,
                    name: 'Email',
                    controller: emailController,
                    icon: Icons.mail,
                  ),
                  SizedBox(height: 20),
                  AuthTextField(
                    status: true,
                    name: 'Password',
                    controller: emailController,
                    icon: Icons.vpn_key,
                  ),
                  SizedBox(height: 25),
                  AuthTextField(
                    status: true,
                    name: 'Confirm Password',
                    controller: emailController,
                    icon: Icons.vpn_key,
                  ),
                  SizedBox(height: 30),
                  AuthButton(
                    status: true,
                    size: size,
                    name: 'SignUp',
                    onTap: () {},
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeacherLoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                            fontSize: 16,
                            color: kOrangeShade,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}