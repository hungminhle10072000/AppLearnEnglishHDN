
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/user_model.dart';
import 'dart:convert';
import 'dart:io';

import 'APIService.dart';


class RegisterRepository {

  static APIService<userDto> create(dynamic body, File? file){
    List<File> _files = [];

    if(file != null){
      _files.add(file);
    }

    const baseAPIEcommerce ="https://be-app-learn-english.herokuapp.com";
    return APIService(
        url: Uri.http(baseAPIEcommerce, "/register"),
        body: body,
        files: _files,
        parse: (response){
          final parsed = json.decode(response.body);
          final data = userDto.fromJSON(parsed);
          //var data = UserModel.fromJSON(dataJson.responsedata);
          return data;
        }
    );

  }

  // static var client = http.Client();
  //
  // static const String appName = "Shopping App";
  // static const String apiURL = 'https://be-app-learn-english.herokuapp.com'; //PROD_URL
  // static const user_API = "register";
  //
  //
  // Future<dynamic> RegisterUser(userDto model, MultipartFile isFileSelected,) async {
  //   var user_URL = user_API;
  //   var url = Uri.http(apiURL, user_URL);
  //   var requestMethod =  "POST";
  //
  //   var request = http.MultipartRequest(requestMethod, url);
  //   request.fields["fullname"] = model.fullname!;
  //   request.fields["username"] = model.username!;
  //   request.fields["password"] = model.password!;
  //   request.fields["email"] = model.email!;
  //   request.fields["gender"] = model.gender!;
  //   request.fields["address"] = model.address!;
  //   request.fields["phonenumber"] = model.phonenumber!;
  //   request.fields["birthday"] = model.birthday!;
  //   request.fields["role"] = "User";
  //
  //   if (model.avatar != null && isFileSelected !=null) {
  //     http.MultipartFile multipartFile = await http.MultipartFile.fromPath('avatar', model.avatar!,);
  //     request.files.add(multipartFile);
  //   }
  //
  //   var response = await request.send();
  //
  //   // if (response.statusCode == 200) {
  //   //   return true;
  //   // } else {
  //   //   return false;
  //   // }
  //   return response;
  // }
//
//   static Future<bool> deleteProduct(productId) async {
//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//     };
//
//     var url = Uri.http(
//       Config.apiURL,
//       Config.productsAPI + "/" + productId,
//     );
//
//     var response = await client.delete(
//       url,
//       headers: requestHeaders,
//     );
//
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }
}