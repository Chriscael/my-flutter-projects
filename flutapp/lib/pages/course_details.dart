// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  CourseDetails({this.courseId, super.key});

  String courseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Detail'),
      ),
      body: Container(),
    );
  }
}
