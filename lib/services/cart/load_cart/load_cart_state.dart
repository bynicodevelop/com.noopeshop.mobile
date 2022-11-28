part of "load_cart_bloc.dart";

abstract class LoadCartState extends Equatable {
  const LoadCartState();

  @override
  List<Object> get props => [];
}

class LoadCartInitialState extends LoadCartState {
  final List<CartInput> cart;
  final bool loading;

  const LoadCartInitialState({
    this.cart = const <CartInput>[],
    this.loading = false,
  });

  @override
  List<Object> get props => [
        cart,
        loading,
      ];
}
