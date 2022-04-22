import 'dart:io';

import 'package:equatable/equatable.dart';


class UserEvent extends Equatable{
  List<Object> get props => [];

}

class StartEvent extends UserEvent {}

class RegisterButtonPressed extends UserEvent{
  final File? file;
  final String? fullname;
  final String? username;
  final String? password;
  final String? email;
  final String? gender;
  final String? address;
  final String? phonenumber;
  final String? birthday;
  final String? role;
  RegisterButtonPressed({required this.file,required this.fullname, required this.username,
    required this.password, required this.email,
    required this.gender, required this.address,
    required this.phonenumber, required this.birthday, required this.role});

}

// class LoginEvent extends Equatable{
//   List<Object> get props => [];
//
// }
//
// class StartEvent extends LoginEvent {}
// class LoginButtonPressed extends LoginEvent{
//   final String username;
//   final String password;
//   LoginButtonPressed({required this.username, required this.password});
// }