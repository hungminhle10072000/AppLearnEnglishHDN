
import 'dart:convert';

import 'package:app_learn_english/models/user_model.dart';

import '../utils/constants/Cons.dart';
import 'package:http/http.dart' as http;

Future<int> registerUser(UserModel userModel) async {
  const String url = baseUrl + '/registerMobile';
  var postUri = Uri.parse(url);
  print(json.encode(userModel.toJson()));
  http.MultipartRequest request = http.MultipartRequest("POST", postUri);
  http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'file',userModel.avartar);


  request.files.add(multipartFile);
  request.fields['strUser']=json.encode(userModel.toJson());
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    return response.statusCode;
  }

}