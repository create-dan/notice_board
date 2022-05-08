import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notice_board/models/user_model.dart';

class NoticeUpload {
  //Store User Details
  Future<void> uploadNotice({
    required String title,
    String? description,
    required String year,
    required String branch,
    required String subject,
    required String noticeType,
    required String imageUrl,
    required String pdfUrl,
    required String owner,
    bool isAdmin = true,
  }) async {
    String collectionName1 = "notice";
    String collectionName2 = "categories";

    final CollectionReference noticeCollection =
        FirebaseFirestore.instance.collection(collectionName1);

    final CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection(collectionName2);

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    var timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;

    // --------------------- Categories -------------------------- //

    // Subject
    String subjectCollectionName = subject;
    await categoryCollection
        .doc("subject")
        .collection(subjectCollectionName)
        .doc()
        .set({
      "title": title,
      "description": description,
      "uid": uid,
      "isAdmin": isAdmin,
      "subject": subject,
      "noticeType": noticeType,
      "imageUrl": imageUrl,
      "pdfUrl": pdfUrl,
      "owner": owner,
      "branch": branch,
      "year": year,
      "timeStamp": DateTime.now().toUtc().millisecondsSinceEpoch,
      "createdAt": Timestamp.now(),
    }, SetOptions(merge: true)).then((value) {});

    // NoticeType
    String noticeTypeCollectionName = noticeType;
    await categoryCollection
        .doc("noticeType")
        .collection(noticeTypeCollectionName)
        .doc()
        .set({
      "title": title,
      "description": description,
      "uid": uid,
      "isAdmin": isAdmin,
      "subject": subject,
      "noticeType": noticeType,
      "imageUrl": imageUrl,
      "pdfUrl": pdfUrl,
      "owner": owner,
      "branch": branch,
      "year": year,
      "timeStamp": DateTime.now().toUtc().millisecondsSinceEpoch,
      "createdAt": Timestamp.now(),
    }, SetOptions(merge: true));

    // Year
    String yearCollectionName = year;
    await categoryCollection
        .doc("year")
        .collection(yearCollectionName)
        .doc()
        .set({
      "title": title,
      "description": description,
      "uid": uid,
      "isAdmin": isAdmin,
      "subject": subject,
      "noticeType": noticeType,
      "imageUrl": imageUrl,
      "pdfUrl": pdfUrl,
      "owner": owner,
      "branch": branch,
      "year": year,
      "timeStamp": DateTime.now().toUtc().millisecondsSinceEpoch,
      "createdAt": Timestamp.now(),
    }, SetOptions(merge: true));

    // Branch
    String branchCollectionName = branch;
    await categoryCollection
        .doc("branch")
        .collection(branchCollectionName)
        .doc()
        .set({
      "title": title,
      "description": description,
      "uid": uid,
      "isAdmin": isAdmin,
      "subject": subject,
      "noticeType": noticeType,
      "imageUrl": imageUrl,
      "pdfUrl": pdfUrl,
      "owner": owner,
      "branch": branch,
      "year": year,
      "timeStamp": DateTime.now().toUtc().millisecondsSinceEpoch,
      "createdAt": Timestamp.now(),
    }, SetOptions(merge: true));
    // --------------------- Categories -------------------------- //

    // All notices

    await noticeCollection.doc(uid).collection('notices').doc().set({
      "title": title,
      "description": description,
      "uid": uid,
      "isAdmin": isAdmin,
      "subject": subject,
      "noticeType": noticeType,
      "imageUrl": imageUrl,
      "pdfUrl": pdfUrl,
      "owner": owner,
      "branch": branch,
      "year": year,
      "timeStamp": DateTime.now().toUtc().millisecondsSinceEpoch,
      "createdAt": Timestamp.now(),
    }, SetOptions(merge: true)).then((value) async {
      print("Notice Created Successfully");
      // await storeNumberOfUsers();
    }).catchError((error) {
      print("Failed to add user: $error");
    });

    await noticeCollection.doc(uid).set(
      {
        "lastNoticeTime": timestamp,
      },
      SetOptions(merge: true),
    );
    return;
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
