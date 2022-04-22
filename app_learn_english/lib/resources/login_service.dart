

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class LoginRepository {
  Future<dynamic> login(String username, String pass) async {
      Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
      final msg = jsonEncode({"grant_type":"password","username":username,"password":pass,"scope":"offline_access"});
    var res = await http.post(
        Uri.parse("http://be-app-learn-english.herokuapp.com/authenticate"),
        headers: headers,
        body: msg
    );
      return res;
  }
}

