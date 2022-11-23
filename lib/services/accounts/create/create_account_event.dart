part of "create_account_bloc.dart";

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAccountEvent extends CreateAccountEvent {
  final AccountModel account;

  const OnCreateAccountEvent({
    required this.account,
  });

  @override
  List<Object> get props => [
        account,
      ];
}
