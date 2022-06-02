import 'package:app_learn_english/models/user_model.dart';

class CommentModel {
  int id;
  String content;
  DateTime time;
  String type;
  int parentId;
  int grammarId;
  int lessonId;
  int vocabularyTopicId;
  int userId;
  UserModel userDto;

  CommentModel(
      this.id,
      this.content,
      this.time,
      this.type,
      this.parentId,
      this.grammarId,
      this.lessonId,
      this.vocabularyTopicId,
      this.userId,
      this.userDto);

  Map<String,dynamic> toJson() => {
    'id':id,
    'content':content,
    'time':time.toIso8601String(),
    'type':type,
    'parentId':parentId,
    'grammarId':grammarId,
    'lessonId':lessonId,
    'vocabularyTopicId':vocabularyTopicId,
    'userId':userId,
    'userDto':userDto
  };
}