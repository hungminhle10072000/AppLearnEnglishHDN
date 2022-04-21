// List<ProductModel> productsFromJson(dynamic str) =>
//     List<ProductModel>.from((str).map((x) => ProductModel.fromJson(x)));

class UserModel {
  late String? id;
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

  UserModel({
    this.id,
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

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullname = json['fullname'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    gender = json['gender'];
    address = json['address'];
    phonenumber = json['phonenumber'];
    birthday = json['birthday'];
    avatar = json['avatar'];
    role = json['role'];
    // productName = json['productName'];
    // productDescription = json['productDescription'];
    // productPrice = json['productPrice'];
    // productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['fullname'] = fullname;
    _data['username'] = username;
    _data['password'] = password;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['address'] = address;
    _data['phonenumber'] = phonenumber;
    _data['birthday'] = birthday;
    _data['avatar'] = avatar;
    _data['role'] = role;

    return _data;
  }
}
