import 'package:flutter/material.dart';

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
                title: Text('Thông tin tác giả',style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
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
                  title: Text('Giáo viên hướng dẫn',style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                  children: <Widget>[
                    ListTile(title: Text('       ThS. Mai Anh Thơ',style: TextStyle(fontSize: 19),)),
                  ],
                  initiallyExpanded: true,
                ),
                ExpansionTile(
                  title: Text('Nhóm sinh viên thực hiện',style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                  children: <Widget>[
                    ListTile(title: Text('       1 - Bùi Văn Nghĩa',style: TextStyle(fontSize: 19),)),
                    ListTile(title: Text('       2 - Hoàng Dương Hùng',style: TextStyle(fontSize: 19),))
                  ],
                  initiallyExpanded: true,
                ),
                SizedBox(height: 60.0),
                Text('    Liên hệ: 09998889999',style: TextStyle(fontSize: 17)),
              ],
            ),
          ),
    );
  }
}