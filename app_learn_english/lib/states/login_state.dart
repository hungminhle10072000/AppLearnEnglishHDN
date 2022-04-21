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