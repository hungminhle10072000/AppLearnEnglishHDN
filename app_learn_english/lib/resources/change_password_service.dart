
import 'dart:convert';
import '../utils/constants/Cons.dart';
import 'package:http/http.dart' as http;



Future<int> changePassword(String username, String passwordOld, String passwordNew) async {
  const String url = baseUrl + '/api/users/change-passWord-mobile';
  var postUri = Uri.parse(url);
  http.MultipartRequest request = http.MultipartRequest("PUT", postUri);
  request.fields['username']=username;
  request.fields['passwordOld']=passwordOld;
  request.fields['passwordNew']=passwordNew;
  final streamedResponse = await request.send();
  final respStr = await streamedResponse.stream.bytesToString();
  int status = int.parse(respStr.trim());
  return status;
}
