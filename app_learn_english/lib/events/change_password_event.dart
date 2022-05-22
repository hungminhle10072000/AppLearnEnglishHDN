
import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangePasswordPutEvent extends ChangePasswordEvent {
  String username;
  String passwordOld;
  String passwordNew;
  ChangePasswordPutEvent({required this.username, required this.passwordOld, required this.passwordNew});
  List<Object?> get props => [username,passwordOld,passwordNew];
}