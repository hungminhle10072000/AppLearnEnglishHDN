
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

  LessonModel({
    required this.id,
    required this.name,
    required this.numPriority,
    required this.video,
    required this.chapterId,
    required this.chapterName,
    required this.numLessonOfChapter,
    required this.courseName,
    required this.courseId
  });
}