part of "create_account_bloc.dart";

abstract class CreateAccountState extends Equatable {
  const CreateAccountState();

  @override
  List<Object> get props => [];
}

class CreateAccountInitialState extends CreateAccountState {}

class CreateAccountLoadingState extends CreateAccountState {}

class CreateAccountSuccessState extends CreateAccountState {
  final AccountEntity account;

  const CreateAccountSuccessState({
    required this.account,
  });

  @override
  List<Object> get props => [
        account,
      ];
}

class CreateAccountFailureState extends CreateAccountState {
  final String code;

  const CreateAccountFailureState({
    required this.code,
  });

  @override
  List<Object> get props => [
        code,
      ];
}
