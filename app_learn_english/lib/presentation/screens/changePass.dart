import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class changePassPage extends StatefulWidget {
  const changePassPage({Key? key}) : super(key: key);

  @override
  _changePassPageState createState() => _changePassPageState();
}

class _changePassPageState extends State<changePassPage> {
  GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatpasswordController = TextEditingController();

  bool _isOldObscure = true;
  bool _isNewObscure = true;
  bool _isNewRepeatObscure = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    repeatpasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void validate() async{
    if (formRegisterKey.currentState!.validate()) {
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
          // child: BlocListener<RegisterBloc, UserState>(
          //   listener: (context, state) {
          //     try {
          //       // if (state is UserLoadingState) {
          //       //   WidgetsBinding.instance!.addPostFrameCallback(
          //       //       (_) => loadingIndicator(context, "Loading..."));
          //       //   //   final snackBar = SnackBar(
          //       //   //   content: const Text('Đăng nhập thành công!'),
          //       //   // );
          //       //   // ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(snackBar);
          //       //   // Navigator.pushNamed(context, 'home');
          //       // } else
          //       if (state is SuccessRegisterUser) {
          //         clearForm();
          //         final snackBar = SnackBar(
          //           content: const Text('Đăng ki thành công!'),
          //         );
          //         ScaffoldMessenger.of(context)
          //           ..removeCurrentSnackBar()
          //           ..showSnackBar(snackBar);
          //         Navigator.pushNamed(context, 'login');
          //       } else if (state is RegisterErrorState) {
          //         final snackBar = SnackBar(
          //           content: const Text('Kiem tra lai thong tin cua ban'),
          //         );
          //         ScaffoldMessenger.of(context)
          //           ..removeCurrentSnackBar()
          //           ..showSnackBar(snackBar);
          //         Navigator.pushNamed(context, 'register');
          //       }
          //     } catch (e) {
          //       var snackbar = SnackBar(content: Text(e.toString()));
          //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
          //     }
          //   },
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
                            controller: usernameController,
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
      //)
    );
  }

}
