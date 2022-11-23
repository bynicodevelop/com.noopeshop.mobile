import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/models/account_model.dart";
import "package:shop/repositories/account_repository.dart";

part "create_event.dart";
part "create_state.dart";

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  final AccountRepository accountRepository;

  CreateBloc(
    this.accountRepository,
  ) : super(CreateInitial()) {
    on<OnCreateAccountEvent>((event, emit) {});
  }
}
