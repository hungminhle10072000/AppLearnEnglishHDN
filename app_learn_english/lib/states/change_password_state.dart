import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}
class ChangePasswordFailure extends ChangePasswordState {
  final message;
  const ChangePasswordFailure({this.message});
  List<Object?> get props => [message];
}
class ChangePasswordSuccess extends ChangePasswordState {
  final uuid;
  const ChangePasswordSuccess({this.uuid});
  List<Object?> get props => [uuid];
}