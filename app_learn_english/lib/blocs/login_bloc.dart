import 'dart:convert';

import 'package:app_learn_english/events/login_event.dart';
import 'package:app_learn_english/resources/login_service.dart';
import 'package:app_learn_english/states/current_user_state.dart';
import 'package:app_learn_english/states/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  // AuthRepository repo;
  //
  // AuthBloc(AuthState initialStatem, this.repo);
  LoginRepository repo;

  LoginBloc({required LoginState initialStatem, required this.repo})
      : super(initialStatem) {
    // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated

    //var ref = await SharedPreferences.getInstance();

    on<StartEvent>(
      (event, emit) => emit(
        LoginInitState(),
      ),
    );
    on<LoginButtonPressed>((event, emit) async {
      var ref = await SharedPreferences.getInstance();
      var status = await repo.login(event.username, event.password);
      if (status.statusCode == 200) {
        // final data = json.decode(status.body);
        final data = json.decode(utf8.decode(status.bodyBytes));
        emit(LoginLoadingState());
        try {
          if (data['user']['role'] == "User") {
            ref.setString("token", data['token']['token']);
            ref.setString("role", data['user']['role']);
            ref.setString("username", data['user']['username']);
            ref.setString("fullname", data['user']['fullname']);
            ref.setString("email", data['user']['email']);
            ref.setString("avartar", data['user']['avartar']);
            ref.setString("phonenumber", data['user']['phonenumber']);
            ref.setString('gender', data['user']['gender']);
            ref.setString('address', data['user']['address']);
            ref.setString('birthday', data['user']['birthday']);
            CurrentUserState.username = data['user']['username'];
            CurrentUserState.token += data['token']['token'];
            CurrentUserState.id = data['user']['id'];
            CurrentUserState.fullname = data['user']['fullname'];
            CurrentUserState.avatar = data['user']['avartar'];

            emit(UserLoginSuccessState());
          } else if (data['user']['role'] == "Admin") {
            ref.setString("token", data['token']['token']);
            ref.setString("role", data['user']['role']);
            ref.setString("username", data['user']['username']);
            ref.setString("fullname", data['user']['fullname']);
            CurrentUserState.username = data['user']['username'];
            CurrentUserState.token += data['token']['token'];
            CurrentUserState.id = data['user']['id'];

            //  Set login late
            ref.setBool("alertLoginLast", false);
            DateTime dateNow = DateTime.now();
            if (ref.getInt("dayLast") != null &&
                ref.getInt("monthLast") != null &&
                ref.getInt("yearLast") != null) {
              int dayLast = ref.getInt("dayLast") ?? 0;
              int monthLast = ref.getInt("monthLast") ?? 0;
              int yearLast = ref.getInt("yearLast") ?? 0;
              var dateLoginLast = DateTime(yearLast, monthLast, dayLast);
              int dayBackLogin = daysBetween(dateLoginLast, dateNow);
              if (dayBackLogin == 0) {
                ref.setBool("alertLoginLast", true);
              }
            }
            int dayNow = dateNow.day;
            int monthNow = dateNow.month;
            int yearNow = dateNow.year;
            ref.setInt("dayLast", dayNow);
            ref.setInt("monthLast", monthNow);
            ref.setInt("yearLast", yearNow);

            emit(AdminLoginSuccessState());
          } else if (data['user']['role'] == null) {
            emit(LoginErrorState(message: "Auth error"));
          }
        } catch (e) {
          emit(LoginErrorState(message: "Auth error"));
          emit(LoginInitState());
        }
      } else {
        emit(LoginErrorState(message: "Auth error"));
        emit(LoginInitState());
      }
    });
  }

  @override
  // TODO: implement initialState
  LoginState get initialState => throw UnimplementedError();
}
