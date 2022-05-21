import 'dart:io';
import 'package:app_learn_english/blocs/user_bloc.dart';
import 'package:app_learn_english/events/user_event.dart';
import 'package:app_learn_english/models/user_model.dart';
import 'package:app_learn_english/states/user_state.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final birthdayController = TextEditingController();
  File? _image;
  String userBlank =
      "https://e7.pngegg.com/pngimages/647/460/png-clipart-computer-icons-open-person-family-icon-black-silhouette-black.png";
  final picker = ImagePicker();

  final format = DateFormat('yyyy-MM-dd');

  late UserBloc _userBloc = UserBloc();

  bool _isInAsyncCall = false;

  String dropdownvalue = "Nam";

  bool _isObscure = true;
  bool _isObscureRepeat = true;

  var genders = [
    'Nam',
    'Nữ'
  ];

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    emailController.dispose();
    numberphoneController.dispose();
    passwordController.dispose();
    repeatpasswordController.dispose();
    nameController.dispose();
    genderController.dispose();
    addressController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  //late RegisterBloc registerBloc;
  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    super.initState();
  }

  void validate() async {
    if (_image == null) {
      final snackBar = const SnackBar(
        content: Text('Vui lòng chọn ảnh đại diện!'),
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else if (formRegisterKey.currentState!.validate()) {
      setState(() {
        _isInAsyncCall = true;
      });
      UserModel userModel = UserModel(
          id: -1,
          fullname: nameController.text.trim(),
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
          email: emailController.text.trim(),
          gender: dropdownvalue,
          address: addressController.text.trim(),
          phonenumber: numberphoneController.text.trim(),
          avartar: _image?.path ?? '',
          role: 'User',
          birthday: birthdayController.text);

      final UserEvent _userEvent = UserRegisterEvent(userModel: userModel);
      _userBloc.add(_userEvent);
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
            child: BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserStateRegisterSuccess) {
                    final snackBar = const SnackBar(
                      content: Text('Đăng ký thành công!'),
                    );
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    Navigator.pushNamed(context, 'login');
                  } else if (state is UserStateRegisterFailure) {
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
                  decoration: const BoxDecoration(
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
                        )),
                    backgroundColor: Colors.transparent,
                    body: ListView(children: [
                      SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 35,
                              right: 35,
                            ),
                            child: Form(
                              key: formRegisterKey,
                              child: Column(
                                children: [
                                  Container(
                                    height: 180,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        color: Colors.grey[300],
                                        image: DecorationImage(
                                            image: (_image != null)
                                                ? FileImage(_image!)
                                                : NetworkImage(userBlank)
                                                    as ImageProvider,
                                            fit: BoxFit.cover)),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                      onTap: () {
                                        getImage();
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value ?? '');
                                      if (value == null || value.isEmpty) {
                                        return 'Yêu cầu nhập email';
                                      } else if (!emailValid) {
                                        return 'Email không hợp lệ!';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
                                      labelText: 'Mật khẩu',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      suffixIcon: IconButton(
                                          icon: Icon(_isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          }),
                                      // hintText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextFormField(
                                    controller: repeatpasswordController,
                                    validator: checkRepeatPassWord,
                                    obscureText: _isObscureRepeat,
                                    decoration: InputDecoration(
                                      labelText: 'Nhập lại mật khẩu',
                                      fillColor: Colors.grey.shade100,
                                      suffixIcon: IconButton(
                                          icon: Icon(_isObscureRepeat
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _isObscureRepeat = !_isObscureRepeat;
                                            });
                                          }),
                                      filled: true,
                                      // hintText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: numberphoneController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty ) {
                                        return 'Yêu cầu nhập số điện thoại';
                                      } else if (value.length < 10) {
                                        return 'Số điện thoại ít nhất 10 chữ số';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Số điện thoại',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: DropdownButton(
                                      itemHeight: 60,
                                      borderRadius: BorderRadius.circular(10.0),
                                      dropdownColor: Colors.grey.shade100,
                                      isExpanded: true,
                                      // Initial Value
                                      value: dropdownvalue,
                                      // Down Arrow Icon
                                      icon: const Icon(Icons.keyboard_arrow_down),

                                      // Array list of items
                                      items: genders.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextFormField(
                                    controller: addressController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Yêu cầu nhập địa chỉ';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Địa chỉ',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  DateTimeField(
                                    format: format,
                                    onShowPicker:
                                        (context, currentValue) async {
                                      final date = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                      return date;
                                    },
                                    controller: birthdayController,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Yêu cầu nhập ngày sinh';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Ngày sinh',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
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
                                            children: const [
                                              Text(
                                                'Đăng ký',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Icon(
                                                Icons.content_paste_rounded,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                ],
                              ),
                            )),
                      ),
                    ]),
                  ),
                ))));
  }

  void clearForm() {
    usernameController.text = "";
    emailController.text = "";
    numberphoneController.text = "";
    passwordController.text = "";
    repeatpasswordController.text = "";
    nameController.text = "";
    genderController.text = "";
    addressController.text = "";
    birthdayController.text = "";
    _image = null;
  }
}
