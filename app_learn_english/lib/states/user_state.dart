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
class UserStateUpdateInfoInitial extends UserState {}
class UserStateUpdateInfoSuccess extends UserState {
  final String message;
  const UserStateUpdateInfoSuccess(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class UserStateUpdateInfoFailure extends UserState {
  final String message;
  const UserStateUpdateInfoFailure(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}