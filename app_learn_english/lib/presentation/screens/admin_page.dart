import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminPage extends StatefulWidget {
  const adminPage({Key? key}) : super(key: key);

  @override
  _adminPageState createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var fullname = "";
  String username = "";


  @override
  void initState(){
    super.initState();
    getData();
  }

  void getData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      fullname = pref.getString('fullname')!;
      username = pref.getString('username')!;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        //Text("Admin page"),
        Column(
            children: [
              Text("Admin page  ${fullname}"),
              SizedBox(height: 30.0),
              Text("Admin page ${username}"),
            ])
    );
  }
}