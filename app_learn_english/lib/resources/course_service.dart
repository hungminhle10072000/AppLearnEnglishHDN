import 'package:app_learn_english/models/chapter_model.dart';
import 'package:app_learn_english/models/course_model.dart';
import 'package:app_learn_english/models/lesson_model.dart';
import 'package:app_learn_english/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_learn_english/utils/constants/Cons.dart';

import '../models/comment_model.dart';

Future<List<CourseModel>> getAllCourses() async {
  const String url = baseUrl + '/api/course/getAll';
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(Uri.parse(url), headers: {'Content-Type': 'application/json'} );
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)) as List;
      final List<CourseModel> courses =
      responseData.map((course) {
        List<dynamic> chaptersDynamic = course['chapters'] ?? [];
        List<ChapterModel> chaptersModel = chaptersDynamic.map((chapter){

          List<dynamic> lessonsDynamic = chapter['lessons'] ?? [];
          List<LessonModel> lessonsModel = lessonsDynamic.map((lesson){
            List<dynamic> commentsDynamic = lesson['commentDtos'] ?? [];
            List<CommentModel> commentsModel = [];
            if (commentsDynamic != null) {
              commentsModel = commentsDynamic.map((comment) {
                dynamic userDynamic = comment['userDto'];
                UserModel userModel = UserModel(id: userDynamic['id'] ?? -1,
                    fullname: userDynamic['fullname'] ?? '', username: userDynamic['username'] ?? '', password: userDynamic['password'] ?? '',
                    email: userDynamic['email'] ?? '', gender: userDynamic['gender'] ?? '', address: userDynamic['address'] ?? '',
                    phonenumber: userDynamic['phonenumber'] ?? '', avartar: userDynamic['avatar'] ?? '', role: userDynamic['role'] ?? '', birthday: userDynamic['birthday'] ?? '') ;
                return CommentModel(comment['id'] ?? -1, comment['content'] ?? '',DateTime.parse(comment['time'].toString()) ?? DateTime.now(), comment['type'] ?? '-1',
                    comment['parentId'] ?? -1, comment['grammarId'] ?? -1,
                    comment['lessonId'] ?? -1, comment['vocabularyTopicId'] ?? -1, comment['userId'] ?? -1 , userModel);
              }).toList();
            }

            return LessonModel(
                id: lesson['id'],
                name: lesson['name'],
                numPriority: lesson['numPriority'],
                video: lesson['video'],
                chapterId: lesson['chapterId'],
                chapterName: lesson['chapterName'],
                numLessonOfChapter: lesson['numLessonOfChapter'],
                courseName: lesson['courseName'],
                courseId: lesson['courseId'],
                commentsModel: commentsModel
            );
          }).toList();
          return ChapterModel(
              id: chapter['id'],
              name: chapter['name'],
              numPriority: chapter['numPriority'],
              courseId: chapter['courseId'],
              courseName: chapter['courseName'],
              numOfLesson:chapter['numOfLesson'],// chapter['numOfLesson']
              lessons: lessonsModel);
        }).toList();
        return CourseModel(
            id: course['id'] ?? -1,
            name: course['name'] ?? '',
            introduce: course['introduce'] ?? '',
            numOfChapter: course['numOfChapter'] ?? 0,
            chapters: chaptersModel,
            image: course['image'] ?? '');
      }).toList();
      return courses;
    } else {
      throw Exception('Cannot load data');
    }
  } catch(exception) {
    throw Exception('Cannot load data');
  }
}
/*

Future<CourseModel> getCourseById(int id) async {
  final String url = baseUrl+ 'edit/'+id.toString();
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(Uri.parse(url) );
    final responseData = json.decode(response.body);
    final CourseModel courses = CourseModel(id: 1, name: 'name', introduce: 'introduce', image: 'image');
    // final CourseModel courses = responseData.map((course) => CourseModel(id: course['id'] ?? -1,name: course['name'] ?? '',introduce: course['introduce'] ?? '',image: course['image'] ?? '')).toList();
    return courses;
  } catch(exception) {
    throw Exception('Cannot load data');
  }
}*/
