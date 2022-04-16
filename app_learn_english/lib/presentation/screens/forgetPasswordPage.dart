import 'package:flutter/material.dart';

class forgetPasswordPage extends StatefulWidget {
  const forgetPasswordPage({Key? key}) : super(key: key);

  @override
  _forgetPasswordPageState createState() => _forgetPasswordPageState();
}

class _forgetPasswordPageState extends State<forgetPasswordPage> {

  GlobalKey<FormState> formFogetKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  void validate() {
    if (formFogetKey.currentState!.validate()) {
      Navigator.pushNamed(context, 'login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(duration: const Duration(seconds: 10), content: Text('Kiểm tra email để lấy mật khẩu mới !!!')),
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            elevation: null,
            backgroundColor: Colors.transparent,
            leading: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            )
        ),
        body: ListView(
          children: [
            SizedBox(height: 50,),
            Center(
              child: Text('Quên mật khẩu', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 40,),
            Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 35,
                right: 35,
              ),
              child: Form(
                key: formFogetKey,
                child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Yêu cầu nhập tên đăng nhập';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Tên đăng nhập',
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Yêu cầu nhập email';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(230.0, 90.0),
                      minimumSize: Size(200.0, 60.0),
                      primary: Colors.orange,
                      shape: StadiumBorder(),
                    ),
                    onPressed: validate,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Đặt lại mật khẩu',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.refresh_sharp,
                          color: Colors.white,
                        ),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
