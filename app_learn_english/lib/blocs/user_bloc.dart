import 'package:app_learn_english/events/user_event.dart';
import 'package:app_learn_english/states/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/register_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStateRegisterInitial()) {
    on<UserRegisterEvent> (_onRegisterUser);
  }

  void _onRegisterUser(UserRegisterEvent event, Emitter<UserState> emit) async {
    final isSuccess = await registerUser(event.userModel);
    if (isSuccess == true) {
      emit(UserStateRegisterSuccess());
    } else {
      emit(UserStateRegisterFailure());
    }
  }
}