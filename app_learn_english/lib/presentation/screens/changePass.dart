import 'package:app_learn_english/blocs/change_password_bloc.dart';
import 'package:app_learn_english/events/change_password_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../states/change_password_state.dart';

class changePassPage extends StatefulWidget {
  const changePassPage({Key? key}) : super(key: key);

  @override
  _changePassPageState createState() => _changePassPageState();
}

class _changePassPageState extends State<changePassPage> {
  GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();
  final passwordOldController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatpasswordController = TextEditingController();

  bool _isOldObscure = true;
  bool _isNewObscure = true;
  bool _isNewRepeatObscure = true;
  bool _isInAsyncCall = false;

  late ChangePasswordBloc _changePasswordBloc = ChangePasswordBloc();
  
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordOldController.dispose();
    passwordController.dispose();
    repeatpasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _changePasswordBloc = BlocProvider.of<ChangePasswordBloc>(context);

    super.initState();
  }

  void validate() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (formRegisterKey.currentState!.validate()) {
      ChangePasswordPutEvent _changePasswordEvent = ChangePasswordPutEvent(
          username: pref.getString("username") ?? "",
          passwordOld:passwordOldController.text.trim(),
          passwordNew:passwordController.text.trim());
      _changePasswordBloc.add(_changePasswordEvent);
      setState(() {
        _isInAsyncCall = true;
      });
    }
  }

  String? checkRepeatPassWord(value) {
    if (value == null || value.isEmpty) {
      return 'Yêu cầu nhập mật khẩu';
    } else if (value.length < 6) {
      return 'Mật khẩu phải >= 6 kí tự';
    } else if (passwordController.text != repeatpasswordController.text) {
      return 'Mật khẩu nhập lại không trùng khớp';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        child: SafeArea(
        child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {

              final snackBar = const SnackBar(
                content: Text('Đổi mật khẩu thành công!'),
              );
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(snackBar);
              Navigator.pushNamed(context, 'home');
            } else if (state is ChangePasswordFailure) {
              String str =state.message;
              final snackBar = SnackBar(
                content: Text(str.substring(37)),
              );
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(snackBar);
              setState(() {
                _isInAsyncCall =false;
              });
            } else {
              final snackBar = SnackBar(
                content: const Text('Đã xảy ra lỗi!'),
              );
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(snackBar);
              setState(() {
                _isInAsyncCall = false;
              });
            }
          },
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
                        Navigator.pushNamed(context, 'home');
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    )),
                backgroundColor: Colors.transparent,
                body: ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Image.asset(
                              'assets/images/logo-removebg-preview.png',
                              width: 150,
                              height: 150)),
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
                                controller: passwordOldController,
                                obscureText: _isOldObscure,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Yêu cầu nhập mật khẩu cũ';
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu cũ',
                                  fillColor: Colors.grey.shade100,
                                  suffixIcon: IconButton(
                                      icon: Icon(_isOldObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isOldObscure = !_isOldObscure;
                                        });
                                      }),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                // readOnly: true,
                                // enableInteractiveSelection: true,
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
                                obscureText: _isNewObscure,
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu mới',
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  suffixIcon: IconButton(
                                      icon: Icon(_isNewObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isNewObscure = !_isNewObscure;
                                        });
                                      }),
                                  // hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              // Text("NHập lại mật khẩu mới:"),
                              // SizedBox(height: 10.0),
                              TextFormField(
                                controller: repeatpasswordController,
                                validator: checkRepeatPassWord,
                                obscureText: _isNewRepeatObscure,
                                decoration: InputDecoration(
                                  labelText: 'Nhập lại mật khẩu mới',
                                  fillColor: Colors.grey.shade100,
                                  filled: _isNewRepeatObscure,
                                  suffixIcon: IconButton(
                                      icon: Icon(_isNewRepeatObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isNewRepeatObscure = !_isNewRepeatObscure;
                                        });
                                      }),
                                  // hintText: 'Password',
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
                                            'Lưu thay đổi',
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
        )
        )
      //)
    ));
  }

}
