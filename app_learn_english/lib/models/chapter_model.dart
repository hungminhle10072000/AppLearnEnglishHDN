import 'package:app_learn_english/models/lesson_model.dart';

class ChapterModel {
  int id;
  String name;
  int numPriority;
  int courseId;
  String courseName;
  int numOfLesson;
  List<LessonModel> lessons;

  ChapterModel({
    required this.id,
    required this.name,
    required this.numPriority,
    required this.courseId,
    required this.courseName,
    required this.numOfLesson,
    required this.lessons
});
}