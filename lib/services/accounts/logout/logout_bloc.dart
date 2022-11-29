import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/repositories/account_repository.dart";

part "logout_event.dart";
part "logout_state.dart";

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AccountRepository accountRepository;

  LogoutBloc(
    this.accountRepository,
  ) : super(LogoutInitialState()) {
    on<OnLogoutEvent>((event, emit) async {
      emit(LogoutLoadingState());

      await accountRepository.logout();

      emit(LogoutSuccessState());
    });
  }
}
