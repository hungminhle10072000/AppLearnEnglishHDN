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

