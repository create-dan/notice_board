import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notice_board/models/user_model.dart';

class MyUserInfo {
  //Store User Details
  Future<void> storeUserDetails({
    required String name,
    String? prn,
    required String email,
    required String password,
    bool isAdmin = false,
  }) async {
    String collectionName = isAdmin ? "admins" : "students";

    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection(collectionName);

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    userCollection.doc(uid).set({
      "Info": {
        "name": name,
        if (!isAdmin) "prn": prn.toString().toUpperCase(),
        "email": email,
        "password": password,
        "uid": uid,
        "isAdmin": isAdmin,
        "year": '',
        "branch": '',
        "club": "",
        "imageUrl": '',
        "category": '',
        "timeStamp": DateTime.now().toUtc().millisecondsSinceEpoch,
        "createdAt": Timestamp.now(),
      }
    }, SetOptions(merge: true)).then((value) async {
      print("User Details Added");
      // await storeNumberOfUsers();
    }).catchError((error) {
      print("Failed to add user: $error");
    });
    return;
  }

  // Store number of users
  Future<void> storeNumberOfUsers() async {
    final CollectionReference appTotalUsersCollection =
        FirebaseFirestore.instance.collection('appTotalUsers');

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    appTotalUsersCollection
        .doc('countUser')
        .set({
          "userTrack": {
            "count": FieldValue.increment(1),
            "emails": {uid: auth.currentUser!.email}
          }
        }, SetOptions(merge: true))
        .then((value) => print("AppTotalUser updated"))
        .catchError((error) => print("Failed to update AppTotalUser $error"));
  }

  // Update UserDetails
  Future<void> updateUserDetails({
    String? name,
    String? year,
    String branch = "",
    String? club,
    String imageUrl = "",
    String category = "",
    bool isAdmin = false,
  }) async {
    String collectionName = isAdmin ? "admins" : "students";

    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection(collectionName);

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    userCollection
        .doc(uid)
        .set({
          "Info": {
            "name": name,
            "year": year,
            "club": club,
            "branch": branch,
            "category": category,
            "imageUrl": imageUrl,
          }
        }, SetOptions(merge: true))
        .then((value) => print("User Details Updated"))
        .catchError((error) => print("Failed to Update user: $error"));

    return;
  }
}
