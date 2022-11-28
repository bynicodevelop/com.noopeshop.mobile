part of "auth_state_bloc.dart";

abstract class AuthStateEvent extends Equatable {
  const AuthStateEvent();

  @override
  List<Object> get props => [];
}

class OnAuthStateEvent extends AuthStateEvent {}
