part of "load_session_bloc.dart";

abstract class LoadSessionEvent extends Equatable {
  const LoadSessionEvent();

  @override
  List<Object> get props => [];
}

class OnLoadSessionEvent extends LoadSessionEvent {}
