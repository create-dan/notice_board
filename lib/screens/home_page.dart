import 'package:flutter/material.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/services/auth_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(UserModel.isAdmin);
    print(UserModel.name);
    print(UserModel.email);

    return Scaffold(
      body: InkWell(
        onTap: () {
          AuthHelper().signOut(context);
        },
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
