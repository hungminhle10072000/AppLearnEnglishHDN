import 'package:app_learn_english/events/user_event.dart';
import 'package:app_learn_english/resources/update_user_info_service.dart';
import 'package:app_learn_english/states/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../resources/register_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStateRegisterInitial()) {
    on<UserRegisterEvent> (_onRegisterUser);
  }

  void _onRegisterUser(UserRegisterEvent event, Emitter<UserState> emit) async {
    final isSuccess = await registerUser(event.userModel);

    var uuid = Uuid();
    String uuidStr = uuid.v1();
    if (isSuccess == 200) {
      emit(UserStateRegisterSuccess(uuid: uuidStr));
    } else if (isSuccess == 409) {
      emit(UserStateRegisterFailure(message: uuidStr+": Tên đăng nhập đã tồn tại!"));
    } else if (isSuccess == 400) {
      emit(UserStateRegisterFailure(message: uuidStr+": Email đã được sử dụng!"));
    } else {
      emit(UserStateRegisterFailure(message: uuidStr+": Đã có lỗi xảy ra!"));
    }
  }
}