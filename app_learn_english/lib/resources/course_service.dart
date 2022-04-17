import 'package:app_learn_english/models/course_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String baseUrl = "https://e9ef-2402-800-6319-11ef-c02b-6caf-6511-454c.ap.ngrok.io/api/course/";

Future<List<CourseModel>> getAllCourses() async {
  final String url = baseUrl + 'getAll';
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(Uri.parse(url) );
    final responseData = json.decode(response.body) as List;
    final List<CourseModel> courses = responseData.map((course) => CourseModel(id: course['id'] ?? -1,name: course['name'] ?? '',introduce: course['introduce'] ?? '',image: course['image'] ?? '')).toList();
    return courses;
  } catch(exception) {
    throw Exception('Cannot load data');
  }
}

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
}