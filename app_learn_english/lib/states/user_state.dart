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
  final message;
  const UserStateUpdateInfoSuccess({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class UserStateUpdateInfoFailure extends UserState {
  final String message;
  final uuid;
  const UserStateUpdateInfoFailure({required this.message,required this.uuid});
  @override
  // TODO: implement props
  List<Object?> get props => [message,uuid];
}