import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  List<Object> get props =>[];

}

class LoginInitState extends LoginState{} // trang thai ban dau
class LoginLoadingState extends LoginState{} // trang thai load khi nhan nut dang nhap
class UserLoginSuccessState extends LoginState{}// DN thanh cong voi user
class AdminLoginSuccessState extends LoginState{}// DN thanh cong voi admin
class LoginErrorState extends LoginState{ // DN loi
  final String message;
  LoginErrorState({required this.message});
}