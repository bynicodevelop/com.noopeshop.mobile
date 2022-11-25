part of "load_page_bloc.dart";

abstract class LoadPageEvent extends Equatable {
  const LoadPageEvent();

  @override
  List<Object> get props => [];
}

class OnLoadPageEvent extends LoadPageEvent {
  final PageInput pageInput;

  const OnLoadPageEvent(
    this.pageInput,
  );

  @override
  List<Object> get props => [
        pageInput,
      ];
}
