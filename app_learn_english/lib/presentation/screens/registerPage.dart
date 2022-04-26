import 'dart:convert';
import 'dart:io';

import 'package:app_learn_english/resources/login_service.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  _registerPageState createState() => _registerPageState();

}


class _registerPageState extends State<registerPage> {
  GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final numberphone = TextEditingController();
  final password = TextEditingController();
  final repeatpasswordController = TextEditingController();
  final name = TextEditingController();
  final gender = TextEditingController();
  final address = TextEditingController();
  final birthday = TextEditingController();
  //File ? f;

  final format=DateFormat('yyyy-MM-dd') ;

  late String _username;
  late String _email;
  late String _pass;
  late String _name;
  late String _numberphone;
  late String _gender;
  late String _address;
  late String _birthday;
  late File? _image;

  String img =
      'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png';



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username.dispose();
    email.dispose();
    numberphone.dispose();
    password.dispose();
    repeatpasswordController.dispose();
    name.dispose();
    gender.dispose();
    address.dispose();
    birthday.dispose();
    super.dispose();
  }

  void validate() async{

    if (formRegisterKey.currentState!.validate()) {
      // if (f != null) {
      //   //RegistUser("", "", f!);
      // }
      _startUploading();
    }


  }

  String? checkRepeatPassWord(value){
    if (value == null || value.isEmpty) {
      return 'Yêu cầu nhập mật khẩu';
    } else if (value.length < 6) {
      return 'Mật khẩu phải >= 6 kí tự';
    } else if(password.text != repeatpasswordController.text){
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
                          //     Pickfile();
                          //   },
                          //   child: f!=null ? Image.file(f!,width: 240,height: 240,fit: BoxFit.fill,) :  Icon(Icons.camera_alt_rounded,size: 60),
                          //
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: _image == null
                                          ? NetworkImage(
                                          'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                          : FileImage(_image!) as ImageProvider,
                                      radius: 50.0,
                                    ),
                                    InkWell(
                                      onTap: onAlertPress,
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40.0),
                                              color: Colors.black),
                                          margin: EdgeInsets.only(left: 70, top: 70),
                                          child: Icon(
                                            Icons.photo_camera,
                                            size: 25,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                                Text('Half Body',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Yêu cầu nhập họ và tên';
                              }
                            },
                            onChanged: ((String name) {
                              setState(() {
                                _name = name;
                                print(_name);
                              });
                            }),
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
                            controller: username,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Yêu cầu nhập tên đăng nhập';
                              }
                            },
                            onChanged: ((String usernameController) {
                              setState(() {
                                _username = usernameController;
                                print(_username);
                              });
                            }),
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
                            controller: email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Yêu cầu nhập email';
                              }
                            },
                            onChanged: ((String email) {
                              setState(() {
                                _email = email;
                                print(_email);
                              });
                            }),
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
                            controller: password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Yêu cầu nhập mật khẩu';
                              } else if (value.length < 6) {
                                return 'Mật khẩu phải >= 6 kí tự';
                              }
                            },
                            onChanged: ((String pass) {
                              setState(() {
                                _pass = pass;
                                print(_pass);
                              });
                            }),
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
                            controller: numberphone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Yêu cầu nhập số điện thoại';
                              }
                            },
                            onChanged: ((String phone) {
                              setState(() {
                                _numberphone = phone;
                                print(_numberphone);
                              });
                            }),
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
                            controller: gender,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Yêu cầu nhập giới tính';
                              }
                            },
                            onChanged: ((String email) {
                              setState(() {
                                _gender = email;
                                print(_gender);
                              });
                            }),
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
                            controller: address,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Yêu cầu nhập địa chỉ';
                              }
                            },
                            onChanged: ((String email) {
                              setState(() {
                                _address = email;
                                print(_address);
                              });
                            }),
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
                          TextFormField(
                            // format: format,
                            // onShowPicker: (context, currentValue) async {
                            //   final date = await showDatePicker(
                            //       context: context,
                            //       firstDate: DateTime(1900),
                            //       initialDate: currentValue ?? DateTime.now(),
                            //       lastDate: DateTime(2100));
                            //   return date;},
                            controller: birthday,
                            validator:
                                (value) {
                              if (value == null ) {
                                return 'Yêu cầu nhập ngày sinh';
                              }
                            },
                            onChanged: ((String email) {
                              setState(() {
                                _birthday = email;
                                print(_birthday);
                              });
                            }),
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
  // }


  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 50,
                    ),
                    Text('Gallery'),
                  ],
                ),
                //onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.jpg',
                      width: 50,
                    ),
                    Text('Take Photo'),
                  ],
                ),
                //onPressed: getCameraImage,
              ),
            ],
          );
        });


  }
  void onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.jpg',
                      width: 50,
                    ),
                    Text('Gallery'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.jpg',
                      width: 50,
                    ),
                    Text('Take Photo'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
  }

// ================================= Image from camera
  Future getCameraImage() async {
    var image = await ImagePicker().getImage( source: ImageSource.camera);

    setState(() {
      _image = image as File;
      Navigator.pop(context);
    });
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _image = image as File;
      Navigator.pop(context);
    });
  }
  ////=================================
  void _startUploading() async {
    if (_image != null ||
        _email != '' ||
        _name != '' ||
        _numberphone != '' ||
        _username != '' ||
        _gender != '' ||
        _address != '' ||
        _birthday != '' ||
        _pass != '') {
      final Map<String, dynamic> response = await _uploadImage(_image!);

      // Check if any error occured
      if (response == null) {
        messageAllert('User details updated successfully', 'Success');
      }
    } else {
      messageAllert('Please Select a profile photo', 'Profile Photo');
    }
  }

  messageAllert(String msg, String ttl) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Okay'),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
// ====================================


  Uri apiUrl = Uri.parse(
      'https://be-app-learn-english.herokuapp.com/register');

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    setState(() {

    });

    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])!.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath(
        'half_body_image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension

//    imageUploadRequest.fields['ext'] = mimeTypeData[1];

    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['username'] = _username;
    imageUploadRequest.fields['email'] = _email;
    imageUploadRequest.fields['fullname'] = _name;
    imageUploadRequest.fields['password'] = _pass;
    imageUploadRequest.fields['phonenumber'] = _numberphone;
    imageUploadRequest.fields['gender'] = _gender;
    imageUploadRequest.fields['address'] = _address;
    imageUploadRequest.fields['birthday'] = _birthday;
    imageUploadRequest.fields['role'] = "User";

    //try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        //return response.;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      _resetState();
      return responseData;
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
  }

  void _resetState() {
    setState(() {
      _name = "";
      _email = "";
      _image = null;
    });
  }



}
