import 'dart:io';

import 'package:app_learn_english/blocs/user_bloc.dart';
import 'package:app_learn_english/events/user_event.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../../states/user_state.dart';

class editinforPage extends StatefulWidget {
  const editinforPage({Key? key}) : super(key: key);

  @override
  _editinforPageState createState() => _editinforPageState();
}

class _editinforPageState extends State<editinforPage> {
  GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final numberphoneController = TextEditingController();
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final birthdayController = TextEditingController();
  var ref = SharedPreferences.getInstance();
  File? _image;
  String userBlank =
      "https://e7.pngegg.com/pngimages/647/460/png-clipart-computer-icons-open-person-family-icon-black-silhouette-black.png";
  final picker = ImagePicker();

  final format = DateFormat('yyyy-MM-dd');

  late UserBloc _userBloc = UserBloc();

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
    nameController.dispose();
    genderController.dispose();
    addressController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    nameController.text="456";
    super.initState();
  }

  void validate() async {
    if (formRegisterKey.currentState!.validate()) {
      UserModel userModel = UserModel(
          id: -1,
          fullname: nameController.text.trim(),
          username: usernameController.text.trim(),
          password: "",
          email: emailController.text.trim(),
          gender: genderController.text.trim(),
          address: addressController.text.trim(),
          phonenumber: numberphoneController.text.trim(),
          avartar: _image?.path ?? '',
          role: 'User',
          birthday: birthdayController.text);

      final UserEvent _userEvent = UserUpdateInfoEvent(userModel: userModel);
      _userBloc.add(_userEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    Navigator.pushNamed(context, 'accinfor');
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                )),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserStateUpdateInfoSuccess) {
                    final snackBar = SnackBar(
                      content: const Text('cập nhật thành công!'),
                    );
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    // Navigator.pushNamed(context, 'login');
                  }
                  if (state is UserStateRegisterFailure) {
                    final snackBar = SnackBar(
                      content: const Text('Đã xảy ra lỗi!'),
                    );
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }
                },
                child: ListView(children: [
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
                                        image: (_image != null)
                                            ? FileImage(_image!)
                                            : NetworkImage(userBlank)
                                                as ImageProvider,
                                        fit: BoxFit.cover)),
                                child: InkWell(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
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
                                initialValue: "123",


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
                                enabled: false,
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
                                            'Lưu thông tin',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
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
            ),
          )),
    );
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
  void clearForm() {
    usernameController.text = "";
    emailController.text = "";
    numberphoneController.text = "";
    nameController.text = "";
    genderController.text = "";
    addressController.text = "";
    birthdayController.text = "";
    _image = null;
  }
}
