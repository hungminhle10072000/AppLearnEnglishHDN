import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserStateRegisterInitial extends UserState {}
class UserStateRegisterFailure extends UserState {}
class UserStateRegisterSuccess extends UserState {}