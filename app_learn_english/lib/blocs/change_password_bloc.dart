import 'package:app_learn_english/events/change_password_event.dart';
import 'package:app_learn_english/states/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../resources/change_password_service.dart';



class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(): super(ChangePasswordInitial()) {
    on<ChangePasswordPutEvent>(_onChangePassword);
  }

  void _onChangePassword(ChangePasswordPutEvent event, Emitter<ChangePasswordState> emit) async {

    var uuid = Uuid();
    String uuidStr = uuid.v1();
    print("ChangePassword");
    final isSuccess = await changePassword(event.username,event.passwordOld, event.passwordNew);
    if (isSuccess == 200) {
      emit(ChangePasswordSuccess(uuid: uuidStr));
    } else if (isSuccess == 400) {
      emit(ChangePasswordFailure(message: uuidStr+": Mật khẩu không chính xác"));
    } else if (isSuccess == 0) {
      emit(ChangePasswordFailure(message: uuidStr+": Đã có lỗi xảy ra"));
    }
  }
}
