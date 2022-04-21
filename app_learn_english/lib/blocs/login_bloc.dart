import 'dart:convert';

import 'package:app_learn_english/events/login_event.dart';
import 'package:app_learn_english/resources/login_service.dart';
import 'package:app_learn_english/states/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState> {

  // AuthRepository repo;
  //
  // AuthBloc(AuthState initialStatem, this.repo);
  LoginRepository repo;

  LoginBloc({required LoginState initialStatem, required this.repo}) : super(initialStatem) {
    // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated

    //var ref = await SharedPreferences.getInstance();

    on<StartEvent>(
          (event, emit) =>
          emit(
            LoginInitState(),
          ),
    );
    on<LoginButtonPressed>((event, emit) async {
      var ref = await SharedPreferences.getInstance();
      print("Chay o day");

      var status = await repo.login(event.username, event.password);
      if(status.statusCode ==  200)
      {
        final data = json.decode(status.body);
        emit(LoginLoadingState());
        try {
          if (data['user']['role'] == "User") {
            ref.setString("token", data['token']['token']);
            ref.setString("role", data['user']['role']);
            ref.setString("username", data['user']['username']);
            ref.setString("fullname", data['user']['fullname']);
            print("Chay o day 11223323");
            emit(UserLoginSuccessState());
          }
          else if (data['user']['role'] == "Admin") {
            ref.setString("token", data['token']['token']);
            ref.setString("role", data['user']['role']);
            ref.setString("username", data['user']['username']);
            ref.setString("fullname", data['user']['fullname']);
            emit(AdminLoginSuccessState());
          }
          else if (data['user']['role'] ==null)
          {
            print("Chay o day 11224455");
            emit(LoginErrorState(message: "Auth error"));
          }
        } catch (e) {
          print("Chay o day 11224455");
          emit(LoginErrorState(message: "Auth error"));
          emit(LoginInitState());
        }
      }
      else
      {
        print("Chay o day 11224455gwedgrdf");
        emit(LoginErrorState(message: "Auth error"));
        emit(LoginInitState());
      }

    });
  }

  @override
  // TODO: implement initialState
  LoginState get initialState => throw UnimplementedError();
}