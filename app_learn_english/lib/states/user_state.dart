import '../models/user_model.dart';
import 'package:equatable/equatable.dart';


class UserState extends Equatable{
  final userDto? user;
  final List<userDto>? users;
  const UserState({this.user, this.users});

  factory UserState.initial() => UserState();

  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class RegisterInitState extends UserState  {} // trang thai ban dau
class UserLoadingState extends UserState  {}// trang thai load khi nhan nut
class SuccessRegisterUser extends UserState  {}// gui ma thanh cong
class RegisterErrorState extends UserState {// quen mat khau loi
  final String message;
  RegisterErrorState({required this.message});
}



