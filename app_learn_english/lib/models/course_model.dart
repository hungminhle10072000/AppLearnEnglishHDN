import 'package:app_learn_english/models/chapter_model.dart';

class CourseModel {
  int id;
  String name;
  String introduce = "";
  String image ="";
  int numOfChapter;
  List<ChapterModel> chapters;
  CourseModel({required this.id,
    required this.name,
    required this.introduce,
    required this.numOfChapter,
    required this.chapters,
    required this.image});
}