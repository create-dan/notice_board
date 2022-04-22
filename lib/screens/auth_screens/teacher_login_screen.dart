// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/models/teachers_model.dart';
import 'package:notice_board/widgets/auth_text_field.dart';
import 'package:notice_board/screens/auth_screens/student_signup_screen.dart';
import 'package:notice_board/screens/auth_screens/teacher_signup_screen.dart';
import 'package:notice_board/services/get_user_data.dart';
import '../../models/user_model.dart';
import '../../services/auth_helper.dart';
import '../../widgets/auth_button.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({Key? key}) : super(key: key);

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(color: kOrangeShade),
        child: Center(
          child: Form(
            key: _formFieldKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Lottie.asset('assets/lottie/teacher.json',
                        height: size.height * 0.4),
                    SizedBox(height: 30),
                    Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    AuthTextField(
                      status: true,
                      name: 'Email',
                      controller: emailController,
                      icon: Icons.mail,
                    ),
                    SizedBox(height: 25),
                    AuthTextField(
                      status: true,
                      name: 'Password',
                      controller: passwordController,
                      icon: Icons.vpn_key,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password?",
                          // style: TextStyle(color: kLightBlueShadeColor),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    AuthButton(
                      status: true,
                      size: size,
                      name: 'Login',
                      onTap: () async {
                        if (_formFieldKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();

                          setState(() {
                            showSpinner = true;
                          });
                          await AuthHelper()
                              .signIn(
                            email: emailController.text,
                            password: passwordController.text,
                            isAdmin: true,
                          )
                              .then((result) {
                            if (result == null) {
                              setState(() {
                                UserModel.isAdmin = true;
                              });

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GetUserData(),
                                ),
                              );
                            } else {
                              setState(() {
                                showSpinner = false;
                              });
                              Fluttertoast.showToast(msg: result);
                            }
                          });
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TeacherSignupScreen(),
                              ),
                            );
                          },
                          child: Text(
                            " Sign Up",
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
      ),
    );
  }
}
