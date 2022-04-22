import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final String email;
  final String avatar;
  final String fullname;

  NavBar(this.fullname, this.avatar, this.email);

  // const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(avatar);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(this.fullname),
            accountEmail: Text(this.email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  this.avatar,
                  // 'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.abc),
            title: Text('Từ vựng'),
            onTap: () => Navigator.pushNamed(context, 'topicVocabulary'),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Ngữ pháp'),
            onTap: () => Navigator.pushNamed(context, 'listGrammar'),
          ),
          ListTile(
            leading: Icon(Icons.video_collection_outlined),
            title: Text('Khóa học'),
            onTap: () => Navigator.pushNamed(context, 'listCourses'),
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('Luyện tập'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.monitor),
            title: Text('Thống kê'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Thông báo'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text('Thông tin cá nhân'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Cài đặt'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Thông tin tác giả'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Thoát'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'login');
            },
          )
        ],
      ),
    );
  }
}
