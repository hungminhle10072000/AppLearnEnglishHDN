import 'dart:io';

import 'package:app_learn_english/models/user_model.dart';
import 'package:app_learn_english/resources/login_service.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

//import '../../resources/register_service.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);
  //final UserModel? userModel;


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

  final format=DateFormat('yyyy-MM-dd') ;

  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;
  late final UserModel? userModel;

  //_registerPageState(this.userModel);


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

  @override
  void initState() {
    super.initState();
    userModel = UserModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        userModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  void validate() {

    if (formRegisterKey.currentState!.validate()) {
      // if (f != null) {
      //   //RegistUser("", "", f!);
      // }
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
                          Text("AVATAR"),
                          // InkWell(
                          //   onTap: (){
                          //     //Pickfile();
                          //   },
                          //   //child: f!=null ? Image.file(f!,width: 240,height: 240,fit: BoxFit.fill,) :  Icon(Icons.camera_alt_rounded,size: 60),
                          //
                          // ),
                          picPicker(
                            isImageSelected,
                            userModel!.avatar ?? "",
                                (file) => {
                              setState(
                                    () {
                                  //model.productPic = file.path;
                                      userModel!.avatar = file.path;
                                  isImageSelected = true;
                                },
                              )
                            },
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
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                              return date;},
                            controller: birthdayController,
                            validator:
                                (value) {
                              if (value == null ) {
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
        ));
  }

  // void Pickfile() async {
  //   FilePickerResult? restule = await FilePicker.platform.pickFiles(
  //       allowedExtensions: ['jpg','png','jpeg'],
  //       allowMultiple: true,
  //       type: FileType.custom,
  //       allowCompression: true
  //   );
    // if(restule!=null){
    //   File f_ = File(restule.files.single.path.toString());
    //   setState(() {
    //     f = f_;
    //   });

    //}
 // }
  static Widget picPicker(
      bool isImageSelected,
      String fileName,
      Function onFilePicked,
      ) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();

    return Column(
      children: [
        fileName.isNotEmpty
            ? isImageSelected
            ? Image.file(
          File(fileName),
          width: 300,
          height: 300,
        )
            : SizedBox(
          child: Image.network(
            fileName,
            width: 200,
            height: 200,
            fit: BoxFit.scaleDown,
          ),
        )
            : SizedBox(
          child: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
            width: 200,
            height: 200,
            fit: BoxFit.scaleDown,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.image, size: 35.0),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.gallery);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                icon: const Icon(Icons.camera, size: 35.0),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.camera);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                 });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

}
