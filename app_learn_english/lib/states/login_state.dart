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


// abstract class LoginState extends Equatable{}
//
// class LoginInitState extends LoginState{
//   List<Object> get props =>[];
// }
// class LoginLoadingState extends LoginState{
//   List<Object> get props =>[];
// }
// class UserLoginSuccessState extends LoginState{
//   List<Object> get props =>[];
// }
// class AdminLoginSuccessState extends LoginState{
//   List<Object> get props =>[];
// }
// class LoginErrorState extends LoginState{
//   // final String message;
//   // LoginErrorState({required this.message});
//   final String error;
//   LoginErrorState(this.error);
//   List<Object> get props =>[error];
// }