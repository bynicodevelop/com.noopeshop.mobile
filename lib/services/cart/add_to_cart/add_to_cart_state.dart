part of "add_to_cart_bloc.dart";

abstract class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

class AddToCartInitialState extends AddToCartState {}

class AddToCartLoadingState extends AddToCartState {}

class AddToCartSuccessState extends AddToCartState {}

class AddToCartFailureState extends AddToCartState {
  final String code;

  const AddToCartFailureState(
    this.code,
  );

  @override
  List<Object> get props => [
        code,
      ];
}
