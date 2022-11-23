import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/exceptions/account_exception.dart";
import "package:shop/repositories/account_repository.dart";

part "validate_account_event.dart";
part "validate_account_state.dart";

class ValidateAccountBloc
    extends Bloc<ValidateAccountEvent, ValidateAccountState> {
  late AccountRepository accountRepository;

  ValidateAccountBloc(
    this.accountRepository,
  ) : super(ValidateAccountInitialState()) {
    on<OnValidateAccountEvent>((event, emit) async {
      emit(ValidateAccountLoadingState());

      try {
        await accountRepository.validateEmail(
          event.code,
        );

        emit(ValidateAccountSuccessState());
      } on AccountException catch (e) {
        emit(ValidateAccountFailureState(
          e.code,
        ));
      }
    });
  }
}
