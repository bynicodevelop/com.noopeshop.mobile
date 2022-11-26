part of "load_bookmark_bloc.dart";

abstract class LoadBookmarkState extends Equatable {
  const LoadBookmarkState();

  @override
  List<Object> get props => [];
}

class LoadBookmarkInitialState extends LoadBookmarkState {
  final List<ProductEntity> products;
  final bool loading;

  const LoadBookmarkInitialState({
    this.products = const [],
    this.loading = false,
  });

  @override
  List<Object> get props => [
        products,
        loading,
      ];
}

class LoadBookmarkFailureState extends LoadBookmarkState {
  final String code;

  const LoadBookmarkFailureState(
    this.code,
  );

  @override
  List<Object> get props => [
        code,
      ];
}
