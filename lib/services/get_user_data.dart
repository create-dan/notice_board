// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../screens/auth_screens/verify_user_screen.dart';

class GetUserData extends StatelessWidget {
  const GetUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String documentId = uid;
    print(auth.currentUser?.email);
    print('GetUserData');

    String collectionName = UserModel.isAdmin ? "admins" : "students";

    CollectionReference users =
        FirebaseFirestore.instance.collection(collectionName);

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
            return Center(
              child: CircularProgressIndicator(color: kVioletShade),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            UserModel.name = data['Info']['name'].toString();
            UserModel.email = data['Info']['email'].toString();
            UserModel.password = data['Info']['password'].toString();
            if (!UserModel.isAdmin) {
              UserModel.prn = data['Info']['prn'].toString();
            }
            // UserModel.imageUrl = data['Info']['imageUrl'].toString();
            // UserModel.bio = data['Info']['bio'].toString();
            // UserModel.dob = data['Info']['dob'].toString();
            UserModel.uid = data['Info']['uid'].toString();

            if (!auth.currentUser!.emailVerified) {
              return VerifyUserScreen();
            }
          }
          return Center(
            child: CircularProgressIndicator(color: kGreenShadeColor),
          );
        },
      ),
    );
  }
}
