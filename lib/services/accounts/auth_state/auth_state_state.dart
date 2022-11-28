part of "auth_state_bloc.dart";

abstract class AuthStateState extends Equatable {
  const AuthStateState();

  @override
  List<Object> get props => [];
}

class AuthStateInitialState extends AuthStateState {
  final bool isAuthenticated;

  const AuthStateInitialState({
    this.isAuthenticated = false,
  });

  @override
  List<Object> get props => [
        isAuthenticated,
      ];
}
