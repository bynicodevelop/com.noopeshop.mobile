part of "load_session_bloc.dart";

abstract class LoadSessionState extends Equatable {
  const LoadSessionState();

  @override
  List<Object> get props => [];
}

class LoadSessionInitialState extends LoadSessionState {}

class LoadSessionLoadingState extends LoadSessionState {}

class LoadSessionSuccessState extends LoadSessionState {
  final SessionEntity session;

  const LoadSessionSuccessState(
    this.session,
  );

  @override
  List<Object> get props => [
        session,
      ];
}

class LoadSessionFailureState extends LoadSessionState {
  final String code;

  const LoadSessionFailureState(
    this.code,
  );

  @override
  List<Object> get props => [
        code,
      ];
}
