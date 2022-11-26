part of "load_product_by_id_bloc.dart";

abstract class LoadProductByIdState extends Equatable {
  const LoadProductByIdState();

  @override
  List<Object> get props => [];
}

class LoadProductByIdInitialState extends LoadProductByIdState {}

class LoadProductByIdLoadingState extends LoadProductByIdState {}

class LoadProductByIdLoadedState extends LoadProductByIdState {
  final ProductEntity productEntity;

  const LoadProductByIdLoadedState(
    this.productEntity,
  );

  @override
  List<Object> get props => [
        productEntity,
      ];
}

class LoadProductByIdFailureState extends LoadProductByIdState {
  final String message;

  const LoadProductByIdFailureState(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}
