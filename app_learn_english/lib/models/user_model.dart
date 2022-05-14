
class UserModel {
  int id;
  String fullname;
  String username;
  String password;
  String email;
  String gender;
  String address;
  String phonenumber;
  String avartar;
  String role;
  String birthday;

  UserModel({
    required this.id,
    required this.fullname,
    required this.username,
    required this.password,
    required this.email,
    required this.gender,
    required this.address,
    required this.phonenumber,
    required this.avartar,
    required this.role,
    required this.birthday
  });

  Map<String,String> toJson() => {
    'fullname':fullname,
    'username':username,
    'password':password,
    'email':email,
    'gender':gender,
    'address':address,
    'phonenumber':phonenumber,
    'avartar':avartar,
    'role':role,
    'birthday': birthday
  };
}