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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                            alignment: Alignment.topLeft,
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
                                    year: data['year'],
                                    branch: data['branch'],
                                    owner: data['owner'],
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
    print(noticeModel2.imageUrl == "");
    print(noticeModel2.pdfUrl == "");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              noticeModel2.owner.toString(),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 5),
            Container(
              width: size.width,
              // height: 200,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (noticeModel2.imageUrl != "")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: NetworkImage(
                                  noticeModel2.imageUrl.toString()),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        else if (noticeModel2.pdfUrl != "")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage("assets/images/pdf.png"),
                              height: 100,
                            ),
                          )
                        else
                          Container(),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                noticeModel2.title.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(
                                noticeModel2.description.toString().length >= 95
                                    ? noticeModel2.description
                                            .toString()
                                            .substring(0, 95) +
                                        " ..."
                                    : noticeModel2.description.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                "TOC",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Chip(
                              label: Text(
                                "Suyog",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.greenAccent,
                            ),
                            SizedBox(width: 10),
                            Chip(
                              label: Text(
                                "Holiday",
                                style: TextStyle(color: Colors.black),
                              ),
                              backgroundColor: Colors.yellowAccent,
                            ),
                            SizedBox(width: 10),
                            Chip(
                              label: Text(
                                "Suyog",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.greenAccent,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(noticeModel2.createdAt.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
