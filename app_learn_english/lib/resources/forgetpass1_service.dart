

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';



// Future<dynamic> LoginUser(String username,String pass) async {
//
//   // Uri uri = Uri.https("https://be-app-learn-english.herokuapp.com/authenticate", unencodedPath)
//
//   Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
//   final msg = jsonEncode({"grant_type":"password","username":username,"password":pass,"scope":"offline_access"});
//
//   var response = await http.post(Uri.parse("https://be-app-learn-english.herokuapp.com/authenticate"),
//     headers: headers,
//     body: msg,
//   );
//
//   final json = jsonDecode(response.body);
//
//   final json_user = json['user'];
//
//   return json_user['role'];
// }
Future<dynamic> ForgetPassUser(String username,String email) async {



  // Uri uri = Uri.https("https://be-app-learn-english.herokuapp.com/authenticate", unencodedPath)

  Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
  final msg = jsonEncode({"grant_type":"password","username":username,"email":email,"scope":"offline_access"});
  var response = await http.post(Uri.parse("https://be-app-learn-english.herokuapp.com/api/users/check-username-email"),
    headers: headers,
    body: msg,
  );

  //final json = jsonDecode(response.body);

  //final json_user = json['user'];

  //return json_user['role'];

  // int status = json.HttpStatus;
  // print(status);
  // return status;

  return response;
}