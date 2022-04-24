// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/getData/get_teacher.dart';
import 'package:notice_board/screens/profile_setup/student_profile_setup.dart';
import 'package:notice_board/screens/profile_setup/teacher_profile_setup.dart';

User? user = FirebaseAuth.instance.currentUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notice Board App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: GetTeachers(),
      // home: AdminProfileSetup(),
    );
  }
}
