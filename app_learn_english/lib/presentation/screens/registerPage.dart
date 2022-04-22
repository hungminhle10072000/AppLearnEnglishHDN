import 'dart:io';

import 'package:app_learn_english/blocs/register_bloc.dart';
import 'package:app_learn_english/resources/login_service.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../events/user_event.dart';
import '../../states/user_state.dart';
import 'CircularLoading.dart';

//import '../../resources/register_service.dart';

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

  late RegisterBloc registerBloc;
  @override
  void initState() {
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  void validate() async{
    if (formRegisterKey.currentState!.validate()) {
      // if (f != null) {
      //   //RegistUser("", "", f!);
      // }
      registerBloc.add(RegisterButtonPressed(
          username: usernameController.text, fullname: nameController.text,email: emailController.text,
          password: passwordController.text, gender:genderController.text,
          address: addressController.text, phonenumber: numberphoneController.text,
          birthday: birthdayController.text, role:"User",
          file: _image));
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
            child: BlocListener<RegisterBloc, UserState>(
              listener: (context, state) {
                try {
                  if (state is UserLoadingState) {
                    WidgetsBinding.instance!.addPostFrameCallback(
                        (_) => loadingIndicator(context, "Loading..."));
                    //   final snackBar = SnackBar(
                    //   content: const Text('Đăng nhập thành công!'),
                    // );
                    // ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(snackBar);
                    // Navigator.pushNamed(context, 'home');
                  } else if (state is SuccessRegisterUser) {
                    clearForm();
                    final snackBar = SnackBar(
                      content: const Text('Đăng ki thành công!'),
                    );
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    Navigator.pushNamed(context, 'login');
                  } else if (state is RegisterErrorState) {
                    final snackBar = SnackBar(
                      content: const Text('Kiem tra lai thong tin cua ban'),
                    );
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    Navigator.pushNamed(context, 'register');
                  }
                } catch (e) {
                  var snackbar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
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
                              Text("AVATAR"),
                              // InkWell(
                              //   onTap: (){
                              //     Pickfile();
                              //   },
                              //   child: f!=null ? Image.file(f!,width: 240,height: 240,fit: BoxFit.fill,) :  Icon(Icons.camera_alt_rounded,size: 60),
                              //
                              // ),
                              Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    color: Colors.grey[300],
                                    image: DecorationImage(
                                        image: (_image != null) ? FileImage(_image!) : NetworkImage(userBlank) as ImageProvider ,
                                        fit: BoxFit.cover
                                    )
                                ),
                                child: InkWell(
                                  child: Icon(Icons.camera_alt_outlined, size: 100, color: Colors.grey,),
                                  onTap: (){
                                    getImage();
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
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
                                //keyboardType: TextInputType.number,
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
                              TextFormField(
                                controller: genderController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Yêu cầu nhập giới tính';
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Giới tính',
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
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
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              DateTimeField(
                                format: format,
                                onShowPicker: (context, currentValue) async {
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
            )));
  }

  // void Pickfile() async {
  //   FilePickerResult? restule = await FilePicker.platform.pickFiles(
  //       allowedExtensions: ['jpg','png','jpeg'],
  //       allowMultiple: true,
  //       type: FileType.custom,
  //       allowCompression: true
  //
  //
  //   );
  //   if(restule!=null){
  //     File f_ = File(restule.files.single.path.toString());
  //     setState(() {
  //       f = f_;
  //     });
  //
  //   }
  //}
  void clearForm(){
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
