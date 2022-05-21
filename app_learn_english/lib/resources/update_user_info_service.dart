import 'dart:convert';

import 'package:app_learn_english/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/Cons.dart';
import 'package:http/http.dart' as http;

Future<int> updateUser(UserModel userModel) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String url = baseUrl + '/api/usersMobile2';
  if (!(userModel.avartar.startsWith("https://") || userModel.avartar.startsWith("http://"))) {
    url = baseUrl + '/api/usersMobile';
  }
  var postUri = Uri.parse(url);
  http.MultipartRequest request = http.MultipartRequest("PUT", postUri);

  if (!(userModel.avartar.startsWith("https://") || userModel.avartar.startsWith("http://"))) {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'file',userModel.avartar);
    request.files.add(multipartFile);
  }

  request.fields['strUser']=json.encode(userModel.toJson());
  final streamedResponse = await request.send();

  final respStr = await streamedResponse.stream.bytesToString();
  int status = 0;

  if (!(respStr.startsWith("https://") || respStr.startsWith("http://"))) {
    status = int.parse(respStr);
  } else {
    pref.setString("avartar", respStr.trim());
    status = 200;
  }

  if (status == 200) {
    pref.setString("fullname", userModel.fullname);
    pref.setString("email", userModel.email);
    pref.setString("phonenumber", userModel.phonenumber);
    pref.setString('gender',userModel.gender);
    pref.setString('address', userModel.address);
    pref.setString('birthday', userModel.birthday);
  }

  print("END");

  return status;
}