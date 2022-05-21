import 'package:app_learn_english/events/user_event.dart';
import 'package:app_learn_english/resources/update_user_info_service.dart';
import 'package:app_learn_english/states/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class UserUpdateInfoBloc extends Bloc<UserEvent, UserState> {
  UserUpdateInfoBloc() : super(UserStateUpdateInfoInitial()) {
    on<UserUpdateInfoEvent> (_onUpdateUser);
  }

  void _onUpdateUser(UserUpdateInfoEvent event, Emitter<UserState> emit) async {
    final isSuccess = await updateUser(event.userModel);
    var uuid = Uuid();
    String uuidStr = uuid.v1();
    if (isSuccess == 200) {
      emit(UserStateUpdateInfoSuccess(message:uuidStr));
    } else if (isSuccess == 409){
      emit( UserStateUpdateInfoFailure(message: "Username đã tồn tại!", uuid: uuidStr ));
    } else if (isSuccess == 400){
      emit( UserStateUpdateInfoFailure(message:"Email đã tồn tại!", uuid: uuidStr));
    } else if (isSuccess == 0){
      emit( UserStateUpdateInfoFailure(message:"Đã có lỗi xảy ra!", uuid: uuidStr));
    } else {
      emit( UserStateUpdateInfoFailure(message:"Đã có lỗi xảy ra!", uuid: uuidStr));
    }
  }
}