// List<ProductModel> productsFromJson(dynamic str) =>
//     List<ProductModel>.from((str).map((x) => ProductModel.fromJson(x)));

class userDto {
  late String? fullname;
  late String? username;
  late String? password;
  late String? email;
  late String? gender;
  late String? address;
  late String? phonenumber;
  late String? birthday;
  late String? avatar;
  late String? role;

  userDto({
    this.fullname,
    this.username,
    this.password,
    this.email,
    this.gender,
    this.address,
    this.phonenumber,
    this.birthday,
    this.avatar,
    this.role
  });

  // userDto.fromJson(Map<String, dynamic> json) {
  //   id = json['_id'];
  //   fullname = json['fullname'];
  //   username = json['username'];
  //   password = json['password'];
  //   email = json['email'];
  //   gender = json['gender'];
  //   address = json['address'];
  //   phonenumber = json['phonenumber'];
  //   birthday = json['birthday'];
  //   avatar = json['avatar'];
  //   role = json['role'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['_id'] = id;
  //   _data['fullname'] = fullname;
  //   _data['username'] = username;
  //   _data['password'] = password;
  //   _data['email'] = email;
  //   _data['gender'] = gender;
  //   _data['address'] = address;
  //   _data['phonenumber'] = phonenumber;
  //   _data['birthday'] = birthday;
  //   _data['avatar'] = avatar;
  //   _data['role'] = role;
  //
  //   return _data;
  // }

  factory userDto.fromJSON(Map<String, dynamic> jsonMap){
    final data = userDto(
        //id: jsonMap["id"],
        fullname: jsonMap["fullname"],
        username: jsonMap["username"],
        password: jsonMap["password"],
        email: jsonMap["email"],
        gender: jsonMap["gender"],
        address: jsonMap["address"],
        phonenumber: jsonMap["phonenumber"],
        birthday: jsonMap["birthday"],
        avatar: jsonMap["avatar"],
        role: jsonMap["role"],
    );
    return data;
  }
}