import 'package:equatable/equatable.dart';

class ForgetPassState extends Equatable{
  List<Object> get props =>[];

}

class ForgetPassInitState extends ForgetPassState{} // trang thai ban dau
class ForgetPassLoadingState extends ForgetPassState{} // trang thai load khi nhan nut quen mat khau
class ForgetPassSuccessState extends ForgetPassState{}// gui ma thanh cong
class ForgetPassErrorState extends ForgetPassState{ // quen mat khau loi
  final String message;
  ForgetPassErrorState({required this.message});
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