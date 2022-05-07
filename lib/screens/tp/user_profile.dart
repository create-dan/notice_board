// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notice_board/helpers/constants.dart';
import 'package:notice_board/main.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/providers/user_model_provider.dart';
import 'package:notice_board/widgets/image_viewer.dart';
import 'package:notice_board/screens/tp/upload_notice_screen.dart';
import 'package:notice_board/services/auth_helper.dart';
import 'package:notice_board/services/firebase_upload.dart';
import 'package:notice_board/widgets/auth_button.dart';
import 'package:notice_board/widgets/my_container.dart';
import 'package:notice_board/widgets/update_info_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../../services/my_user_info.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // image source
  File? _image;

  DateTime? date;

  // upload task
  UploadTask? task;

  String urlDownload =
      'https://thumbs.dreamstime.com/b/solid-purple-gradient-user-icon-web-mobile-design-interface-ui-ux-developer-app-137467998.jpg';

  bool isEditOn = false;
  bool isEditName = false;
  bool isEditBio = false;
  bool isDisable = false;

  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  late TextEditingController fullNameController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    print(UserModel.isAdmin);
    fullNameController = TextEditingController();
    bioController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController = TextEditingController();
    bioController = TextEditingController();
    super.dispose();
  }

  bool showSpinner = false;
  bool isAdmin = UserModel.isAdmin;

  @override
  Widget build(BuildContext context) {
    Color mainColor = isAdmin ? kOrangeShade : kVioletShade;
    Size size = MediaQuery.of(context).size;

    String name = Provider.of<UserModelProvider>(context).name;
    String branch = Provider.of<UserModelProvider>(context).branch;
    String year = Provider.of<UserModelProvider>(context).year;
    String email = Provider.of<UserModelProvider>(context).email;
    String imageUrl = Provider.of<UserModelProvider>(context).imageUrl;
    String prn = Provider.of<UserModelProvider>(context).prn;
    String adminCategory =
        Provider.of<UserModelProvider>(context).adminCategory;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      progressIndicator: CircularProgressIndicator(color: mainColor),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text('Profile'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Stack(
                        children: [
                          Hero(
                            tag: kHeroTag1,
                            child: ImageViewer(
                              isAdmin: UserModel.isAdmin,
                              urlDownload: imageUrl,
                              finalWidth: MediaQuery.of(context).size.width,
                              finalHeight: 500,
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isEditOn = true;
                                });
                                buildShowModalBottomSheet(context);
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(300),
                                    ),
                                  ),
                                  Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Form(
                              key: _formFieldKey,
                              child: Column(
                                children: [
                                  SubName(subName: 'Name'),
                                  MyContainer2(
                                    icon: FontAwesomeIcons.user,
                                    text: name,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return SingleChildScrollView(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                              ),
                                              child: UpdateInfoBottomSheet(
                                                header: 'Enter Name',
                                                initialText: name,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  if (!isAdmin) ...[
                                    SubName(subName: 'Year'),
                                    MyContainer2(
                                      icon: FontAwesomeIcons.calendar,
                                      text: year,
                                      isEditable: false,
                                    ),
                                    SubName(subName: 'PRN'),
                                    MyContainer2(
                                      icon: FontAwesomeIcons.handPeace,
                                      text: prn,
                                      isEditable: false,
                                    ),
                                  ],
                                  if (isAdmin) ...[
                                    SubName(subName: 'Admin Role'),
                                    MyContainer2(
                                      icon: FontAwesomeIcons.handPeace,
                                      text: adminCategory,
                                      isEditable: false,
                                    ),
                                  ],
                                  if (adminCategory != category[0] &&
                                      adminCategory != category[1]) ...[
                                    SubName(subName: 'Branch'),
                                    MyContainer2(
                                      icon: FontAwesomeIcons.codeBranch,
                                      text: branch,
                                      isEditable: false,
                                    ),
                                  ],
                                  if (adminCategory == category[4]) ...[
                                    SubName(subName: 'Year of Study'),
                                    MyContainer2(
                                      icon: Icons.category,
                                      text: year,
                                      isEditable: false,
                                    ),
                                  ],
                                  SubName(subName: 'Email'),
                                  MyContainer2(
                                    icon: Icons.email,
                                    text: email,
                                    isEditable: false,
                                    isEmail: true,
                                  ),
                                  SizedBox(height: 30),
                                  AuthButton(
                                    isAdmin: UserModel.isAdmin,
                                    size: size,
                                    name: "Logout",
                                    onTap: () {
                                      AuthHelper().signOut(
                                        context: context,
                                        isAdmin: isAdmin,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    Color mainColor = isAdmin ? kOrangeShade : kVioletShade;

    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return WillPopScope(
          onWillPop: () {
            setState(() {
              isEditOn = false;
            });
            return Future.value(true);
          },
          child: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose an option to upload image',
                  style: TextStyle(
                    fontSize: 22,
                    color: mainColor,
                  ),
                ),
                SizedBox(height: 20),
                Divider(color: Colors.grey),
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
                          color: mainColor,
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
                Divider(color: Colors.grey),
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
                          color: mainColor,
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
          ),
        );
      },
    );
  }

  Future getImage(ImageSource imageSource) async {
    try {
      final image =
          await ImagePicker().pickImage(source: imageSource, imageQuality: 50);

      if (image == null) return;

      FirebaseStorageMethods().deleteImage(
          Provider.of<UserModelProvider>(context, listen: false).imageUrl);

      final imgTemp = File(image.path);

      setState(() {
        _image = imgTemp;
      });

      setState(() {
        showSpinner = true;
      });

      await uploadImage();

      await MyUserInfo()
          .updateUserDetails(
            name: UserModel.name,
            imageUrl:
                Provider.of<UserModelProvider>(context, listen: false).imageUrl,
            isAdmin: isAdmin,
            category: UserModel.adminCategory.toString(),
            year: UserModel.year,
            branch: UserModel.branch.toString(),
          )
          .then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kOrangeShade,
                content: Text(
                  'Profile picture updated successfully',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
      setState(() {
        showSpinner = false;
        isEditOn = false;
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: 'Failed to pick image $e');
    }
  }

  // Upload image
  Future uploadImage() async {
    // print('image $_image');
    setState(() {
      showSpinner = true;
    });
    if (_image == null) return;

    final imageName = path.basename(_image!.path);

    String imgPath = isAdmin ? "admins" : "students";
    final destination = 'files/$imgPath/$imageName';

    task = FirebaseUpload.uploadFile(destination, _image!);

    if (task == null) return null;

    final snapshot = await task!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();

    Provider.of<UserModelProvider>(context, listen: false)
        .updateImageUrl(urlDownload);
    // print('urlDownload $urlDownload');
    setState(() {
      showSpinner = false;
    });
  }
}

class SubName extends StatelessWidget {
  const SubName({
    Key? key,
    required this.subName,
  }) : super(key: key);

  final String subName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            subName,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
