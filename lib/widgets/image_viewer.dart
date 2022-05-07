// ignore_for_file: prefer_const_constructors

import 'package:custom_full_image_screen/custom_full_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/helpers/constants.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key? key,
    required this.urlDownload,
    this.width = 150,
    this.height = 150,
    required this.finalWidth,
    required this.finalHeight,
    required this.isAdmin,
  }) : super(key: key);

  final String urlDownload;
  final double width, height;
  final double finalHeight, finalWidth;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    Color mainColor = isAdmin ? kOrangeShade : kVioletShade;

    return ImageCachedFullscreen(
      imageUrl: urlDownload,
      imageBorderRadius: 300,
      imageWidth: width,
      imageHeight: height,
      imageDetailsHeight: finalHeight,
      imageDetailsWidth: finalWidth,
      // iconBackButtonColor: kGreenShadeColor,
      // hideBackButtonDetails: false,
      // backgroundColorDetails: ,
      imageDetailsFit: BoxFit.cover,
      // hideAppBarDetails: true,
      imageFit: BoxFit.cover,
      withHeroAnimation: false,
      placeholderDetails: CircularProgressIndicator(color: mainColor),
      placeholder: CircularProgressIndicator(color: mainColor),
      errorWidget: urlDownload == ''
          ? CircularProgressIndicator(color: mainColor)
          : Center(
              child: Text(
                'Image corrupted',
                style: TextStyle(color: Colors.red, fontSize: 32),
              ),
            ),
    );
  }
}
