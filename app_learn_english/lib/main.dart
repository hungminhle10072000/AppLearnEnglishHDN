import 'package:app_learn_english/presentation/screens/forgetPasswordPage.dart';
import 'package:app_learn_english/presentation/screens/homePage.dart';
import 'package:app_learn_english/presentation/screens/loginPage.dart';
import 'package:app_learn_english/presentation/screens/registerPage.dart';
import 'package:app_learn_english/presentation/screens/adminPage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
      MaterialApp(
        title: 'Cùng nhau học tiếng anh',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: <String, WidgetBuilder>{
          'home': (context) => HomePage(),
          'login' : (context) => loginPage(),
          'register': (context) => registerPage(),
          'forget': (context) => forgetPasswordPage(),
          'admin': (context) => adminPage(),
        },
      )
  );
}
