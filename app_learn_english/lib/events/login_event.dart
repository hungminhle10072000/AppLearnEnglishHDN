import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable{
  List<Object> get props => [];

}

class StartEvent extends LoginEvent {}
class LoginButtonPressed extends LoginEvent{
  final String username;
  final String password;
  LoginButtonPressed({required this.username, required this.password});
}