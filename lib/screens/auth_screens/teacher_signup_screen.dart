// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/helpers/validators.dart';
import 'package:notice_board/models/teachers_model.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/services/get_admin_data.dart';
import 'package:notice_board/widgets/auth_text_field.dart';
import 'package:notice_board/screens/auth_screens/teacher_login_screen.dart';
import 'package:notice_board/services/get_student_data.dart';
import '../../services/auth_helper.dart';
import '../../services/my_user_info.dart';
import '../../widgets/auth_button.dart';

class TeacherSignupScreen extends StatefulWidget {
  const TeacherSignupScreen({Key? key}) : super(key: key);

  @override
  State<TeacherSignupScreen> createState() => _TeacherSignupScreenState();
}

class _TeacherSignupScreenState extends State<TeacherSignupScreen> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

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
              padding: const EdgeInsets.symmetric(horizontal: 32.0)
                  .copyWith(top: 80),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "SignUp",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    AuthTextField(
                      isAdmin: true,
                      name: 'Name',
                      controller: nameController,
                      icon: FontAwesomeIcons.user,
                      validator: nameValidator,
                    ),
                    SizedBox(height: 20),
                    AuthTextField(
                      isAdmin: true,
                      name: 'Email',
                      controller: emailController,
                      icon: Icons.mail,
                      validator: emailValidator,
                    ),
                    SizedBox(height: 20),
                    AuthTextField(
                      isAdmin: true,
                      name: 'Password',
                      controller: passwordController,
                      icon: Icons.vpn_key,
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 25),
                    AuthTextField(
                      isAdmin: true,
                      name: 'Confirm Password',
                      controller: cPasswordController,
                      icon: Icons.vpn_key,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Confirm password and password doesn't match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    AuthButton(
                      isAdmin: true,
                      size: size,
                      name: 'SignUp',
                      onTap: () async {
                        if (_formFieldKey.currentState!.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          await AuthHelper()
                              .signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            isAdmin: true,
                          )
                              .then((result) async {
                            if (result == null) {
                              setState(() {
                                UserModel.isAdmin = true;
                              });
                              await MyUserInfo().storeUserDetails(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                isAdmin: true,
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GetAdminData(),
                                ),
                              );
                            } else {
                              setState(() {
                                showSpinner = false;
                              });
                              Fluttertoast.showToast(
                                  msg: result, backgroundColor: Colors.red);
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
      ),
    );
  }
}
