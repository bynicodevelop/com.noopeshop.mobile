part of "create_bloc.dart";

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAccountEvent extends CreateEvent {
  final AccountModel account;

  const OnCreateAccountEvent({
    required this.account,
  });

  @override
  List<Object> get props => [
        account,
      ];
}
