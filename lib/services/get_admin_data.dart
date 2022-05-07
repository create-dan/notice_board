// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/screens/profile_setup/student_profile_setup.dart';
import 'package:notice_board/screens/profile_setup/admin_profile_setup.dart';
import 'package:notice_board/screens/tp/upload_notice_screen.dart';
import 'package:notice_board/screens/tp/user_profile.dart';
import 'package:notice_board/screens/tp/tp_screen.dart';
import '../models/user_model.dart';
import '../screens/auth_screens/verify_user_screen.dart';

class GetAdminData extends StatelessWidget {
  const GetAdminData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String documentId = uid;
    print('GetUserData');
    print("Uid $documentId");

    String collectionName = "admins";

    CollectionReference users =
        FirebaseFirestore.instance.collection(collectionName);

    print("users.id");
    print(users.id);

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong, Please try again'),
            );
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            print("Not Admin");
            return Center(
              child: CircularProgressIndicator(color: kVioletShade),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            UserModel.name = data['Info']['name'].toString();
            UserModel.isAdmin = data['Info']['isAdmin'];
            UserModel.email = data['Info']['email'].toString();
            UserModel.password = data['Info']['password'].toString();
            UserModel.imageUrl = data['Info']['imageUrl'].toString();
            UserModel.branch = data['Info']['branch'].toString();
            UserModel.uid = data['Info']['uid'].toString();
            UserModel.adminCategory = data['Info']['category'].toString();
            UserModel.prn = data['Info']['prn'].toString();
            UserModel.year = data['Info']['year'].toString();

            if (auth.currentUser!.emailVerified) {
              print("Email verified");
              print("Admin Category ${UserModel.adminCategory}");
              if (UserModel.adminCategory == null ||
                  UserModel.adminCategory == "") {
                return AdminProfileSetup();
              }
            } else {
              return VerifyUserScreen();
            }
            // return HomePage();
            return TpScreen();
          }
          return Center(
            child: CircularProgressIndicator(color: kOrangeShade),
          );
        },
      ),
    );
  }
}
