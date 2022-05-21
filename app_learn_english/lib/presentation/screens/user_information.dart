import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../blocs/update_info_bloc.dart';
import '../../events/user_event.dart';
import '../../models/user_model.dart';
import '../../states/current_user_state.dart';
import '../../states/user_state.dart';


class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {

  GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final numberphoneController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final birthdayController = TextEditingController();
  bool _isInAsyncCall = false;
  File? _image;
  String userBlank =
      "https://e7.pngegg.com/pngimages/647/460/png-clipart-computer-icons-open-person-family-icon-black-silhouette-black.png";
  final picker = ImagePicker();

  final format = DateFormat('yyyy-MM-dd');

  late UserUpdateInfoBloc _userBloc = UserUpdateInfoBloc();
  int id = -1;
  String fullname ="";
  String username="";
  String email="";
  String gender="";
  String address="";
  String phonenumber="";
  String avartar="";
  String birthday="";
  String dropdownvalue = "";

  var genders = [
    'Nam',
    'Nữ'
  ];


  void getData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = CurrentUserState.id;
      fullname = pref.getString('fullname') ?? '';
      username = pref.getString('username') ?? '';
      phonenumber = pref.getString('phonenumber') ?? '';
      gender = pref.getString('gender') ?? "";
      if (gender.toUpperCase().trim() == "NAM") {
        dropdownvalue = "Nam";
      } else {
        dropdownvalue = "Nữ";
      }
      address = pref.getString('address') ?? '';
      email = pref.getString('email') ?? '';
      avartar = pref.getString('avartar') ?? '';
      birthday = pref.getString('birthday') ?? '';
    });

  }

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
    addressController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserUpdateInfoBloc>(context);
    super.initState();
    getData();
  }


  void validate() async {
    if (formRegisterKey.currentState!.validate()) {
      setState(() {
        _isInAsyncCall =true;
      });
      UserModel userModel = UserModel(
          id: id,
          fullname: nameController.text.trim(),
          username: usernameController.text.trim(),
          password: "",
          email: emailController.text.trim(),
          gender: dropdownvalue.trim(),
          address: addressController.text.trim(),
          phonenumber: numberphoneController.text.trim(),
          avartar: _image?.path ?? avartar,
          role: 'User',
          birthday: birthdayController.text);

      if (isChanged(userModel)) {
        final UserEvent _userEvent = UserUpdateInfoEvent(userModel: userModel);
        _userBloc.add(_userEvent);
      } else {
        Navigator.pushNamed(context, 'home');
        const snackBar = SnackBar(
          content: Text('Cập nhật thành công!'),
        );
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  bool isChanged( UserModel userModel) {
    if (userModel.fullname != fullname) {
      return true;
    }
    if (userModel.username != username) {
      return true;
    }
    if (userModel.email != email) {
      return true;
    }
    if (userModel.gender != gender) {
      return true;
    }
    if (userModel.address != address) {
      return true;
    }
    if (userModel.phonenumber != phonenumber) {
      return true;
    }
    if (userModel.birthday != birthday) {
      return true;
    }
    if (userModel.avartar.isNotEmpty) {
      return true;
    }
    return false;
  }

  void initialData() {
    setState(() {
      usernameController.text = username;
      emailController.text = email;
      numberphoneController.text = phonenumber;
      nameController.text = fullname;
      addressController.text = address;
      birthdayController.text = birthday;
      if (gender.toUpperCase().trim() == "NAM") {
        dropdownvalue = "Nam";
      } else {
        dropdownvalue = "Nữ";
      }
      _image = null;
    });

  }



  @override
  Widget build(BuildContext context) {
    // initialData();
    // emailController.selection = TextSelection.fromPosition(TextPosition(offset: emailController.text.length));
    if (usernameController.text.isEmpty) {
      usernameController.text = username;
      emailController.text = email;
      numberphoneController.text = phonenumber;
      nameController.text = fullname;

      if (gender.toUpperCase().trim() == "NAM") {
        dropdownvalue = "Nam";
      } else {
        dropdownvalue = "Nữ";
      }
      addressController.text = address;
      birthdayController.text = birthday;
    }
    Future<bool> _onBackPressed() async {
      Navigator.pushNamed(context, 'home');
      return true;
    }

    return ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        child: WillPopScope(child: SafeArea(
            child: BlocListener<UserUpdateInfoBloc, UserState>(
              listener: (context, state) {
                setState(() {
                  _isInAsyncCall =false;
                });
                if (state is UserStateUpdateInfoSuccess) {
                  final snackBar = const SnackBar(
                    content: Text('Cập nhật thành công!'),
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                  Navigator.pushNamed(context, 'home');
                }
                if (state is UserStateUpdateInfoFailure) {
                  final snackBar = SnackBar(
                    content: Text(state.message),
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
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
                            Navigator.pushNamed(context, 'home');
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          ),
                        )),
                    backgroundColor: Colors.transparent,
                    body: SafeArea(
                      child: ListView(children: [
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
                                          borderRadius: BorderRadius.circular(200),
                                          color: Colors.grey[300],
                                          image: DecorationImage(
                                              image: (_image != null)
                                                  ? FileImage(_image!)
                                                  : NetworkImage(avartar)
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
                                    const SizedBox(height: 20.0),
                                    // Container(
                                    //   child:
                                      DropdownButton(
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
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.grey.shade100,
                                    //     borderRadius: BorderRadius.circular(10.0),
                                    //   ),
                                    // ),
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
                                        if (value == null || value.toString().isEmpty) {
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
                                              maximumSize: Size(MediaQuery.of(context).size.width / 2.5, 90.0),
                                              minimumSize: Size(20.0, 60.0),
                                              primary: Colors.orange,
                                              shape: StadiumBorder(),
                                            ),
                                            onPressed: validate,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children:  const [
                                                Text(
                                                  'Lưu ',
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
                                            )),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              maximumSize: Size(MediaQuery.of(context).size.width / 2.5, 90.0),
                                              minimumSize: Size(20.0, 60.0),
                                              primary: Colors.orange,
                                              shape: StadiumBorder(),
                                            ),
                                            onPressed: initialData,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: const [
                                                Text(
                                                  'Làm mới',
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
                                    const SizedBox(height: 20.0),
                                  ],
                                ),
                              )),
                        ),
                      ]),
                    ),
                  )),
            )
        ), onWillPop: _onBackPressed)
    );
  }
}
