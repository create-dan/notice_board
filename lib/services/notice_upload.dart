import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notice_board/models/user_model.dart';

class NoticeUpload {
  //Store User Details
  Future<void> uploadNotice({
    required String title,
    String? description,
    required String subject,
    required String noticeType,
    required String imageUrl,
    required String pdfUrl,
    bool isAdmin = true,
  }) async {
    String collectionName = "notice";

    final CollectionReference noticeCollection =
        FirebaseFirestore.instance.collection(collectionName);

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    noticeCollection.doc(uid).set({
      "title": title,
      "description": description,
      "uid": uid,
      "isAdmin": isAdmin,
      "subject": subject,
      "noticeType": noticeType,
      "imageUrl": imageUrl,
      "pdfUrl": pdfUrl,
      "timeStamp": DateTime.now().toUtc().millisecondsSinceEpoch,
      "createdAt": Timestamp.now(),
    }, SetOptions(merge: true)).then((value) async {
      print("User Details Added");
      // await storeNumberOfUsers();
    }).catchError((error) {
      print("Failed to add user: $error");
    });
    return;
  }

  // Store number of users
  Future<void> storeNoticeNumbers() async {
    final CollectionReference appTotalUsersCollection =
        FirebaseFirestore.instance.collection('totalNotices');

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    appTotalUsersCollection
        .doc('countNotices')
        .set({
          "noticeTrack": {
            "count": FieldValue.increment(1),
            "emails": {uid: auth.currentUser!.email}
          }
        }, SetOptions(merge: true))
        .then((value) => print("Total Notice updated"))
        .catchError((error) => print("Failed to update Total Notice $error"));
  }

  // Update UserDetails
  Future<void> updateNoticeDetails({
    required String title,
    String? description,
    required String subject,
    required String noticeType,
    required String imageUrl,
    required String pdfUrl,
    bool isAdmin = true,
  }) async {
    String collectionName = "notice";

    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection(collectionName);

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    userCollection
        .doc(uid)
        .set({
          "title": title,
          "description": description,
          "uid": uid,
          "isAdmin": isAdmin,
          "subject": subject,
          "noticeType": noticeType,
          "imageUrl": imageUrl,
          "pdfUrl": pdfUrl,
          "timeStamp": DateTime.now().toUtc().millisecondsSinceEpoch,
          "createdAt": Timestamp.now(),
        }, SetOptions(merge: true))
        .then((value) => print("User Details Updated"))
        .catchError((error) => print("Failed to Update user: $error"));

    return;
  }
}
