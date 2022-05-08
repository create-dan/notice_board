// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/screens/tp/tp_screen.dart';
import 'package:notice_board/services/notice_upload.dart';
import 'package:notice_board/widgets/auth_button.dart';
import 'package:path/path.dart' as path;
import '../../helpers/constants.dart';
import '../../services/firebase_upload.dart';

class UploadNoticeImageScreen extends StatefulWidget {
  const UploadNoticeImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadNoticeImageScreen> createState() =>
      _UploadNoticeImageScreenState();
}

class _UploadNoticeImageScreenState extends State<UploadNoticeImageScreen> {
  // image source
  File? _image;

  // upload task
  UploadTask? task1, task2;

  PlatformFile? pickedFile;

  String urlDownload = "";

  String urlDownload2 = "";

  bool showSpinner = false;

  void publishNotice() async {
    setState(() {
      showSpinner = true;
    });
    await uploadImage();
    await uploadPdf();

    setState(() {
      NoticeModel1.imageUrl = urlDownload;
      NoticeModel1.pdfUrl = urlDownload2;
    });

    await NoticeUpload().uploadNotice(
      title: NoticeModel1.title.toString(),
      description: NoticeModel1.description.toString(),
      subject: NoticeModel1.subject.toString(),
      noticeType: NoticeModel1.noticeType.toString(),
      imageUrl: NoticeModel1.imageUrl.toString(),
      pdfUrl: NoticeModel1.pdfUrl.toString(),
      year: NoticeModel1.year.toString(),
      branch: NoticeModel1.branch.toString(),
      owner: NoticeModel1.owner.toString(),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TpScreen(),
      ),
    );
    setState(() {
      showSpinner = false;
    });
    print("OK");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(color: kOrangeShade),
        child: SafeArea(
          child: SizedBox(
            // height: size.height,
            // width: size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  "Upload Notice Image",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    // color: kOrangeShade,
                  ),
                ),
                SizedBox(height: 30),
                _image == null
                    ? Container(
                        width: size.width * 0.5,
                        height: size.width * 0.7,
                        decoration: BoxDecoration(
                          border: Border.all(color: kOrangeShade, width: 10),
                          image: DecorationImage(
                            image: AssetImage("assets/images/strange.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: kOrangeShade, width: 10),
                        ),
                        child: Image.file(
                          _image!,
                          alignment: Alignment.center,
                          width: size.width * 0.5,
                          height: size.width * 0.7,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    buildShowModalBottomSheet(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: kOrangeShade, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Choose Image",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(child: Text("OR")),
                SizedBox(height: 30),
                InkWell(
                  onTap: selectPdf,
                  child: Text(
                    "Choose Pdf",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15),
                if (pickedFile != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Text(
                      pickedFile!.name,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                SizedBox(height: 30),
                AuthButton(
                  size: size,
                  name: "Publish",
                  onTap: () async {
                    publishNotice();
                  },
                  isAdmin: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose an option to upload image',
                style: TextStyle(
                  fontSize: 22,
                  color: kVioletShade,
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: InkWell(
                  onTap: () {
                    getImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.camera,
                        color: kVioletShade,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: InkWell(
                  onTap: () {
                    getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FontAwesomeIcons.image,
                        color: kVioletShade,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Pick image
  Future getImage(ImageSource imageSource) async {
    try {
      final image =
          await ImagePicker().pickImage(source: imageSource, imageQuality: 50);

      if (image == null) return;

      final imgTemp = File(image.path);

      setState(() {
        _image = imgTemp;
      });

      await uploadImage();
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: 'Failed to pick image $e');
    }
  }

  // Upload image
  Future uploadImage() async {
    // print('image $_image');
    if (_image == null) return;

    final imageName = path.basename(_image!.path);
    final destination = 'files/noticeImage/$imageName';

    task1 = FirebaseUpload.uploadFile(destination, _image!);

    if (task1 == null) return null;

    final snapshot = await task1!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();

    // print('urlDownload $urlDownload');
  }

  Future selectPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf"],
    );
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadPdf() async {
    if (pickedFile == null) return;
    final path = "files/noticesPdf/${pickedFile!.name}";
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    task2 = ref.putFile(file);

    if (task2 == null) return null;

    final snapshot = await task2!.whenComplete(() {});
    urlDownload2 = await snapshot.ref.getDownloadURL();

    print("urlDownload2 $urlDownload2");
  }
}
