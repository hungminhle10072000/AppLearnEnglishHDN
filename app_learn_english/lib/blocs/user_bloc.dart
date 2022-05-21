import 'package:app_learn_english/events/user_event.dart';
import 'package:app_learn_english/resources/update_user_info_service.dart';
import 'package:app_learn_english/states/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/register_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStateRegisterInitial()) {
    on<UserRegisterEvent> (_onRegisterUser);
    on<UserUpdateInfoEvent> (_onUpdateUser);
  }

  void _onRegisterUser(UserRegisterEvent event, Emitter<UserState> emit) async {
    final isSuccess = await registerUser(event.userModel);
    if (isSuccess == 200) {
      emit(UserStateRegisterSuccess());
    } else {
      emit(UserStateRegisterFailure());
    }
  }
  void _onUpdateUser(UserUpdateInfoEvent event, Emitter<UserState> emit) async {
    final isSuccess = await updateUser(event.userModel);
    if (isSuccess == 200) {
      print("Success");
      emit(const UserStateUpdateInfoSuccess("Success"));
    } else if (isSuccess == 409){
      emit(const UserStateUpdateInfoFailure("Username đã tồn tại!"));
    } else if (isSuccess == 400){
      print("trùng email");
      emit(const UserStateUpdateInfoFailure("Email đã tồn tại!"));
    } else if (isSuccess == 0){
      emit(const UserStateUpdateInfoFailure("Đã có lỗi xảy ra!"));
    } else {
      emit(const UserStateUpdateInfoFailure("Đã có lỗi xảy ra!"));
    }
  }
}