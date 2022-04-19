import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  List<Object> get props =>[];

}

class LoginInitState extends LoginState{}
class LoginLoadingState extends LoginState{}
class UserLoginSuccessState extends LoginState{}
class AdminLoginSuccessState extends LoginState{}
class LoginErrorState extends LoginState{
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