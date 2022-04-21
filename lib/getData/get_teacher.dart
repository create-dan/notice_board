// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/models/teachers_model.dart';
import 'package:notice_board/screens/auth_screens/landing_screen.dart';
import 'package:notice_board/screens/auth_screens/student_login_screen.dart';

class GetTeachers extends StatefulWidget {
  const GetTeachers({Key? key}) : super(key: key);

  @override
  State<GetTeachers> createState() => _GetTeachersState();
}

class _GetTeachersState extends State<GetTeachers> {
  @override
  Widget build(BuildContext context) {
    CollectionReference adminCollection =
        FirebaseFirestore.instance.collection('adminList');

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: adminCollection.doc("tUplnNX9yHCKkMVkkh8Q").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong, Please try again'),
            );
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            debugPrint(snapshot.data!.get("emails"));
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print('Teachers list');
            print(data['emails']);

            TeachersModel.teachersEmail = data['emails'];
            return LandingScreen();
          }
          return Center(
            child: CircularProgressIndicator(color: kVioletShade),
          );
        },
      ),
    );
  }
}
