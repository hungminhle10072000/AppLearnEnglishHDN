

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



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
Future<dynamic> RegistUser(String username,String pass) async {

 // Uri uri = Uri.https("https://be-app-learn-english.herokuapp.com/authenticate", unencodedPath)

  Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw==',
    "scope":"offline_access"};

  var request  =  await http.MultipartRequest("POST",Uri.parse("https://be-app-learn-english.herokuapp.com/register"));



  request.headers.addAll(headers);

  request.fields['fullname']= "123456";

  request.fields['username']= "123456";
  request.fields['password']= "123456";
  request.fields['email']= "123456";
  request.fields['gender']= "123456";
  request.fields['address']= "123456";
  request.fields['birthday']= "123456";
  request.fields['role']= "User";
  request.fields['phonenumber']= "123456789";
  List<String> list = ["123456","123456","1234567","1234567","123456","1234567","1234567","1234567","123567"];

  for(int i = 0 ; i <list.length;i++){
    request.files.add(http.MultipartFile.fromString("userDto", list[i]));
  }


  var responsive = await request.send();
  print(responsive.statusCode);





}