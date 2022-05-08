// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/models/notice_model.dart';
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: noticeCollection
                        .doc(UserModel.uid)
                        .collection('notices')
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        print(snapshot.data!.docs.length);
                        return Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;

                                String sendAt = data['createdAt']
                                    .toDate()
                                    .toString()
                                    .substring(11, 16);

                                var timestamp = data['timestamp'];
                                print("data");
                                print(data);
                                return NoticeBubble(
                                  noticeModel2: NoticeModel2(
                                    title: data['title'],
                                    description: data['description'],
                                    subject: data['subject'],
                                    noticeType: data['noticeType'],
                                    imageUrl: data['imageUrl'],
                                    pdfUrl: data['pdfUrl'],
                                    createdAt: sendAt,
                                    tags: [],
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
      ),
    );
  }
}

class NoticeBubble extends StatelessWidget {
  const NoticeBubble({Key? key, required this.noticeModel2}) : super(key: key);

  final NoticeModel2 noticeModel2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
    );
  }
}
