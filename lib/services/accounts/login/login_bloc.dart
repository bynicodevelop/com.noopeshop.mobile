import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import 'package:shop/exceptions/account_exception.dart';
import "package:shop/inputs/login_input.dart";
import "package:shop/repositories/account_repository.dart";

part "login_event.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late AccountRepository accountRepository;

  LoginBloc(
    this.accountRepository,
  ) : super(LoginInitialState()) {
    on<OnLoginEvent>((event, emit) async {
      emit(LoginLoadingState());

      try {
        await accountRepository.login(
          LoginInput(
            email: event.email,
            password: event.password,
          ),
        );

        emit(LoginSuccessState());
      } on AccountException catch (e) {
        emit(LoginFailureState(e.code));
      }
    });
  }
}
