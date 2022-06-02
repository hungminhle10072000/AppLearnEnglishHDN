
import 'package:app_learn_english/models/comment_model.dart';

class LessonModel {
  int id;
  String name;
  int numPriority;
  String video;
  int chapterId;
  String chapterName;
  int numLessonOfChapter;
  String courseName;
  int courseId;
  List<CommentModel> commentsModel;

  LessonModel({
    required this.id,
    required this.name,
    required this.numPriority,
    required this.video,
    required this.chapterId,
    required this.chapterName,
    required this.numLessonOfChapter,
    required this.courseName,
    required this.courseId,
    required this.commentsModel
  });
}