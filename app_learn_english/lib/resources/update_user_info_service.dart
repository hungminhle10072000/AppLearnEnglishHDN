import 'dart:convert';

import 'package:app_learn_english/models/user_model.dart';
import 'package:app_learn_english/states/current_user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/Cons.dart';
import 'package:http/http.dart' as http;

Future<int> updateUser(UserModel userModel) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String url = baseUrl + '/api/usersMobile2';
  if (userModel.avartar.isNotEmpty) {
    url = baseUrl + '/api/usersMobile';
  }
  var postUri = Uri.parse(url);
  print(json.encode(userModel.toJson()));
  http.MultipartRequest request = http.MultipartRequest("PUT", postUri);

  if (userModel.avartar.isNotEmpty) {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'file',userModel.avartar);
    request.files.add(multipartFile);
  }

  print(url);
  request.fields['strUser']=json.encode(userModel.toJson());
  http.StreamedResponse streamedResponse = await request.send();
  int status =200;
  await streamedResponse.stream.transform(utf8.decoder).listen((value) async  {
    print ("VALUE:"+value);
    int intValue = int.parse(value.trim());
    status = intValue;
  });

  if (status == 200) {
    pref.setString("fullname", userModel.fullname);
    pref.setString("email", userModel.email);
    if (userModel.avartar.isNotEmpty) {
      pref.setString("avartar", userModel.avartar);
    }
    pref.setString("phonenumber", userModel.phonenumber);
    pref.setString('gender',userModel.gender);
    pref.setString('address', userModel.address);
    pref.setString('birthday', userModel.birthday);
  }

  print("END");

  return status;
}