
import 'package:app_learn_english/models/user_model.dart';
import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserRegisterEvent extends UserEvent {
  final UserModel userModel;
  UserRegisterEvent({required this.userModel});
}

class UserUpdateInfoEvent extends UserEvent {
  final UserModel userModel;
  UserUpdateInfoEvent({required this.userModel});
}