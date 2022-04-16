import 'package:app_learn_english/models/course_model.dart';
import 'package:flutter/material.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseModel courseDetail;
  const CourseDetailPage({Key? key,required this.courseDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Course Name: " + courseDetail.name),
    );
  }
}
