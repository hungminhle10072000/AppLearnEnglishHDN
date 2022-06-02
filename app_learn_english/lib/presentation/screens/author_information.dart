import 'package:app_learn_english/presentation/screens/forgetPasswordPage.dart';
import 'package:app_learn_english/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../events/login_event.dart';
import '../../states/login_state.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class authorInformatinPage extends StatefulWidget {
  const authorInformatinPage({Key? key}) : super(key: key);

  @override
  _authorInformatinPageState createState() => _authorInformatinPageState();
}

class _authorInformatinPageState extends State<authorInformatinPage> {


  @override
  Widget build(BuildContext context) {
    return
       Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
                elevation: null,
                backgroundColor: Colors.transparent,
                leading: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'home');
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                )),
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                SizedBox(height: 100.0),
                ExpansionTile(
                  title: Text('Giáo viên hướng dẫn'),
                  children: <Widget>[
                    ListTile(title: Text('Cô: Nguyễn Thủy An')),
                  ],
                ),
                ExpansionTile(
                  title: Text('Nhóm sinh viên thực hiện'),
                  children: <Widget>[
                    ListTile(title: Text('1 - Từ Hữu Hà Đức')),
                    ListTile(title: Text('2 - Bùi Văn Nghĩa')),
                    ListTile(title: Text('3 - Hoàng Dương Hùng')),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}