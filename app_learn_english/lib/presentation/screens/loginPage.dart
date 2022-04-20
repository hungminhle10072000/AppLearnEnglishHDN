import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login_bloc.dart';
import '../../events/login_event.dart';
import '../../states/login_state.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  late LoginBloc authBloc;



  @override
  void initState() {
    authBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validate(context) {
    if (formKey.currentState!.validate()) {

      // If email is valid adding new Event [SignInRequested].
      BlocProvider.of<LoginBloc>(context).add(
          LoginButtonPressed(username: usernameController.text, password: passwordController.text));
      // authBloc.add(LoginButtonPressed(
      //     username: usernameController.text,
      //     password: passwordController.text));
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
        child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          //state = LoginInitState;
          try{
            if (state is UserLoginSuccessState){
              Navigator.pushNamed(context, 'home');
            }else if (state is AdminLoginSuccessState){
              Navigator.pushNamed(context, 'admin');
            }
            else  if (state is LoginErrorState){
              final snackBar = SnackBar(
                content: const Text('Tên đăng nhập hoặc mật khẩu không đúng!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pushNamed(context, 'login');
            }
          }
          catch(e)
          {
            var snackbar = SnackBar(content: Text(e.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
    },
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text('Cùng nhau học tiếng anh')
          // ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                        top: 60.0,
                      ),
                      child: Image.asset(
                          'assets/images/logo-removebg-preview.png',
                          width: 150,
                          height: 150)),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 250,
                    left: 35,
                    right: 35,
                  ),
                  child: Form(
                    key: formKey,
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
                        SizedBox(height: 30.0),
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
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
                                onPressed: () {
                                  validate(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Đăng nhập',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'forget');
                              },
                              child: Text(
                                'Quên mật khẩu ?',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Nếu chưa có tài khoản ? ',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontStyle: FontStyle.italic),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'register');
                                  },
                                  child: Text(
                                    'Đăng ký',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
