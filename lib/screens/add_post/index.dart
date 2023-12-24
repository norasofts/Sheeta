import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheeta/screens/add_post/step_one.dart';
import 'package:sheeta/screens/add_post/step_two.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? imgPath;
  String? imgName;

  void updateImg(Uint8List? path, String? name) {
    if (mounted) {
      setState(() {
        imgPath = path;
        imgName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return imgPath == null
        ? StepOne(updateImg: updateImg)
        : StepTwo(updateImg: updateImg, imgPath: imgPath, imgName: imgName);
  }
}