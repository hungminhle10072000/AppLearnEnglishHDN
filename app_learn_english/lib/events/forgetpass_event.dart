import 'package:equatable/equatable.dart';

class ForgetPassEvent extends Equatable{
  List<Object> get props => [];

}

class StartEvent extends ForgetPassEvent {}
class ForgetPassButtonPressed extends ForgetPassEvent{
  final String username;
  final String email;
  ForgetPassButtonPressed({required this.username, required this.email});
}