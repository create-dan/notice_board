import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:notice_board/helpers/constants.dart';
import '../models/user_model.dart';

class UserModelProvider extends ChangeNotifier {
  String get name => UserModel.name.toString();

  String get prn => UserModel.prn.toString();

  String get year => UserModel.year.toString();

  String get imageUrl => UserModel.imageUrl.toString();

  String get branch => UserModel.branch.toString();

  String get email => UserModel.email.toString();

  String get adminCategory => UserModel.adminCategory.toString();

  bool get isAdmin => UserModel.isAdmin;

  Color get mainColor => isAdmin ? kOrangeShade : kVioletShade;

  void updateName(newName) {
    UserModel.name = newName;
    notifyListeners();
  }

  void updateBio(newPrn) {
    UserModel.prn = newPrn;

    notifyListeners();
  }

  void updateImageUrl(newImageUrl) {
    UserModel.imageUrl = newImageUrl;
    notifyListeners();
  }

// void updateDob(newDob) {
//   UserModel.dob = newDob;
//
//   notifyListeners();
// }
}
