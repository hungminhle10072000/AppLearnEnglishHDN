import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class APIService {
  static var client = http.Client();

  // static Future<List<UserModel>?> getUser() async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //   };
  //
  //   var url = Uri.http(
  //     'https://be-app-learn-english.herokuapp.com',
  //     "register",
  //   );
  //
  //   var response = await client.get(
  //     url,
  //     headers: requestHeaders,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //
  //     return productsFromJson(data["data"]);
  //
  //     //return true;
  //   } else {
  //     return null;
  //   }
  // }

  static const String appName = "Shopping App";
  static const String apiURL = 'https://be-app-learn-english.herokuapp.com'; //PROD_URL
  static const user_API = "register";


  static Future<bool> saveUser(
      UserModel model,
      //bool isEditMode,
      bool isFileSelected,
      ) async {
    var user_URL = user_API;

    // if (isEditMode) {
    //   user_URL = user_URL + "/" + model.id.toString();
    // }

    var url = Uri.http(apiURL, user_URL);

    //var requestMethod = isEditMode ? "PUT" : "POST";
    var requestMethod =  "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["fullname"] = model.fullname!;
    request.fields["username"] = model.username!;
    request.fields["password"] = model.password!;
    request.fields["email"] = model.email!;
    request.fields["gender"] = model.gender!;
    request.fields["address"] = model.address!;
    request.fields["phonenumber"] = model.phonenumber!;
    request.fields["birthday"] = model.birthday!;
    //request.fields["birthday"] = model.birthday!;
    request.fields["role"] = "User";

    if (model.avatar != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'avatar',
        model.avatar!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
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