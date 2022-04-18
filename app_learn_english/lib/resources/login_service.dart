

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';



Future<dynamic> LoginUser(String username,String pass) async {

 // Uri uri = Uri.https("https://be-app-learn-english.herokuapp.com/authenticate", unencodedPath)

  Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
  final msg = jsonEncode({"grant_type":"password","username":username,"password":pass,"scope":"offline_access"});

  var response = await http.post(Uri.parse("https://be-app-learn-english.herokuapp.com/authenticate"),
    headers: headers,
    body: msg,
  );

   final json = jsonDecode(response.body);

   final json_user = json['user'];

   return json_user['role'];
}
// Future<dynamic> RegistUser(String username,String pass,File file) async {
//
//   Map<String, String> headers = {"Content-type": "multipart/form-data"};
//   // Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw==',
//   //   "scope":"offline_access"};
//
//   var request  =  await http.MultipartRequest("POST",Uri.parse("https://be-app-learn-english.herokuapp.com/register"));
//
//
// print(file.path);
//   request.files.add(
//     http.MultipartFile(
//       'file',
//       file.readAsBytes().asStream(),
//       file.lengthSync(),
//       filename: "filename",
//       contentType: MediaType('image', 'jpeg'),
//     ),
//   );
//     // request.fields['userDto[fullname]']= "thaikaio";
//     // request.fields['userDto[username]']= "thaikaio";
//     // request.fields['userDto[password]']= "thaikaio";
//     // request.fields['userDto[email]']= "thaikaio@gmail.com";
//     // request.fields['userDto[gender]']= "Nam";
//     // request.fields['userDto[address]']= "thaikaio";
//     // request.fields['userDto[phonenumber]']= "0347826465";
//     // request.fields['userDto[birthday]']= "2021-02-03";
//     // request.fields['userDto[role]']= "User";
//
//     request.fields['fullname']= "thaikaio";
//     request.fields['username']= "thaikaio";
//     request.fields['password']= "thaikaio";
//     request.fields['email']= "thaikaio@gmail.com";
//     request.fields['gender']= "Nam";
//     request.fields['address']= "thaikaio";
//     request.fields['phonenumber']= "0347826465";
//     request.fields['birthday']= "2021-02-03";
//     request.fields['role']= "User";
//     request.fields['avartar']= "https://web-english.s3.ap-southeast-1.amazonaws.com/1650216500230-POKEMON.png";
//     request.headers.addAll(headers);
//
//
//
//   var responsive = await request.send();
//   print(responsive.statusCode);
//   responsive.stream.transform(utf8.decoder).listen((event) {
//     print(FontWeight.values);
//   });
//}


// Future<dynamic> ForgetPassUser(String username,String email) async {
//
//   // Uri uri = Uri.https("https://be-app-learn-english.herokuapp.com/authenticate", unencodedPath)
//
//   Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
//   final msg = jsonEncode({"grant_type":"password","username":username,"email":email,"scope":"offline_access"});
//
//   var response = await http.post(Uri.parse("https://be-app-learn-english.herokuapp.com/api/users/check-username-email"),
//     headers: headers,
//     body: msg,
//   );
//
//   final json = jsonDecode(response.body);
//
//   //final json_user = json['user'];
//
//   //return json_user['role'];
//   final status = json.statusCode;
//   print(status);
//   return status;
// }