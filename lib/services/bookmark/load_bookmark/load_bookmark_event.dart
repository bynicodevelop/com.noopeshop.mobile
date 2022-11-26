part of "load_bookmark_bloc.dart";

abstract class LoadBookmarkEvent extends Equatable {
  const LoadBookmarkEvent();

  @override
  List<Object> get props => [];
}

class OnLoadBookmarkEvent extends LoadBookmarkEvent {}
