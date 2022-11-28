import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/utils/logger.dart";

part "auth_state_event.dart";
part "auth_state_state.dart";

class AuthStateBloc extends Bloc<AuthStateEvent, AuthStateState> {
  final AccountRepository accountRepository;

  AuthStateBloc(
    this.accountRepository,
  ) : super(const AuthStateInitialState()) {
    on<OnAuthStateEvent>((event, emit) {
      info("Authentication state", data: {
        "isAuthenticated": accountRepository.isAuthenticated,
      });

      emit(AuthStateInitialState(
        isAuthenticated: accountRepository.isAuthenticated,
      ));
    });
  }
}
