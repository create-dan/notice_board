// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/models/user_model.dart';

class AllNotices extends StatefulWidget {
  const AllNotices({Key? key}) : super(key: key);

  @override
  State<AllNotices> createState() => _AllNoticesState();
}

class _AllNoticesState extends State<AllNotices> {
  CollectionReference noticeCollection =
      FirebaseFirestore.instance.collection("notice");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: noticeCollection
                      .doc(UserModel.uid)
                      .collection('notices')
                      .orderBy('lastNoticeTime', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    // print(snapshot.data!.docs.length);
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: kOrangeShade),
                          ],
                        ),
                      );
                    }
                    if (snapshot.data != null && snapshot.hasData) {
                      print(snapshot.data!.docs);
                      return Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;

                              print("snapshot");
                              String sendAt = data['createdAt']
                                  .toDate()
                                  .toString()
                                  .substring(11, 16);

                              var timestamp = data['timestamp'];
                              print("data");
                              print(data);
                              return Container(
                                child: Column(
                                  children: [
                                    Text(data['title']),
                                    Text(data['description']),
                                    Text(data['subject']),
                                    Text(data['noticeType']),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
