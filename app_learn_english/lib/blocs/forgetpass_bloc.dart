

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../events/forgetpass_event.dart';
import '../resources/forgetpass_service.dart';
import '../states/forgetpass_state.dart';


class ForgetPassBloc extends Bloc<ForgetPassEvent,ForgetPassState> {

  final ForgetPassRepository repo;

  ForgetPassBloc({required this.repo}) : super(ForgetPassInitState()) {


    on<StartEvent>(
          (event, emit) =>
          emit(
            ForgetPassInitState(),
          ),
    );
    on<ForgetPassButtonPressed>((event, emit) async {
      print("Chay quen mat khau");
      var status = await repo.ForgetPassUser(event.username, event.email);
      emit(ForgetPassLoadingState());
      if(status.statusCode ==  200)
      {
            emit(ForgetPassSuccessState());
      }
      else
      {
        print("Chay loi roi");
        emit(ForgetPassErrorState(message: "Auth error"));
      }

    });
  }
}
