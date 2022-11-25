part of "load_page_bloc.dart";

abstract class LoadPageState extends Equatable {
  const LoadPageState();

  @override
  List<Object> get props => [];
}

class LoadPageInitialState extends LoadPageState {}

class LoadPageLoadingState extends LoadPageState {}

class LoadPageLoadedState extends LoadPageState {
  final PageEntity page;

  const LoadPageLoadedState(
    this.page,
  );

  @override
  List<Object> get props => [
        page,
      ];
}

class LoadPageFailureState extends LoadPageState {
  final String code;

  const LoadPageFailureState(
    this.code,
  );

  @override
  List<Object> get props => [
        code,
      ];
}
