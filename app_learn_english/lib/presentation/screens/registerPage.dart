import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final numberphoneController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatpasswordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    emailController.dispose();
    numberphoneController.dispose();
    passwordController.dispose();
    repeatpasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void validate() {
    if (formRegisterKey.currentState!.validate()) {
      Navigator.pushNamed(context, 'login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(duration: const Duration(seconds: 10), content: Text('Đăng ký thành công !!!')),
        );
    }
  }

  String? checkRepeatPassWord(value){
    if (value == null || value.isEmpty) {
      return 'Yêu cầu nhập mật khẩu';
    } else if (value.length < 6) {
      return 'Mật khẩu phải >= 6 kí tự';
    } else if(passwordController.text != repeatpasswordController.text){
      return 'Mật khẩu nhập lại không trùng khớp';
    } else {
      return null;
    }
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
        backgroundColor: Colors.transparent,
        body: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Image.asset('assets/images/logo-removebg-preview.png',
                      width: 150, height: 150)),
            ],
          ),
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 35,
                  right: 35,
                ),
                child: Form(
                  key: formRegisterKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Yêu cầu nhập họ và tên';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Họ và tên',
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
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
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Yêu cầu nhập mật khẩu';
                          } else if (value.length < 6) {
                            return 'Mật khẩu phải >= 6 kí tự';
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          // hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: repeatpasswordController,
                        validator: checkRepeatPassWord,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Nhập lại mật khẩu',
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          // hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: numberphoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Yêu cầu nhập số điện thoại';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại',
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
                                    'Đăng ký',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Icon(
                                    Icons.content_paste_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                )),
          ),
        ]),
      ),
    ));
  }
}
