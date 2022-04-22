


import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/user_event.dart';
import '../resources/APIService.dart';
import '../resources/register_service.dart';
import '../states/user_state.dart';


class RegisterBloc extends Bloc<UserEvent,UserState> {

  //RegisterRepository repo;

  RegisterBloc() : super(const UserState()) {

    on<StartEvent>(
          (event, emit) =>
          emit(
            RegisterInitState(),
          ),
    );

    try{
      on<RegisterButtonPressed>((event, emit) async {
//UserLoadingState
        emit(UserLoadingState());
        await Future.delayed(const Duration(seconds: 1));

        print("Chay quen mat khau");
        dynamic userDto;

        userDto = {
          'fullname': event.fullname,
          'username': event.username,
          'password': event.password,
          'email': event.email,
          'gender': event.gender,
          'address': event.address,
          'phonenumber': event.phonenumber,
          'birthday': event.birthday,
          'role': event.role,
        };

        await APIWeb().postFormData(RegisterRepository.create(userDto, event.file));
        emit(SuccessRegisterUser());

      });
    }
    catch(e){
      print("Chay loi roi");
      emit(RegisterErrorState(message: "Auth error"));
    }

  }
  @override
  // TODO: implement initialState
  UserState get initialState => throw UnimplementedError();
}
