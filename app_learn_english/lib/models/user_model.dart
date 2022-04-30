
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
    required this.role
  });
}