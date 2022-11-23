import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/entities/account_entity.dart";
import "package:shop/exceptions/account_exception.dart";
import "package:shop/models/account_model.dart";
import "package:shop/repositories/account_repository.dart";

part "create_account_event.dart";
part "create_account_state.dart";

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final AccountRepository accountRepository;

  CreateAccountBloc(
    this.accountRepository,
  ) : super(CreateAccountInitialState()) {
    on<OnCreateAccountEvent>((event, emit) async {
      emit(CreateAccountLoadingState());

      try {
        final AccountEntity accountEntity = await accountRepository.create(
          event.account,
        );

        emit(CreateAccountSuccessState(
          account: accountEntity,
        ));
      } on AccountException catch (e) {
        emit(CreateAccountFailureState(
          code: e.code,
        ));
      }
    });
  }
}
