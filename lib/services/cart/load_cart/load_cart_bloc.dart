import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/inputs/cart_input.dart";
import "package:shop/repositories/cart_repository.dart";
import "package:shop/repositories/product_repository.dart";

part "load_cart_event.dart";
part "load_cart_state.dart";

class LoadCartBloc extends Bloc<LoadCartEvent, LoadCartState> {
  late CartRepository cartRepository;
  late ProductRepository productRepository;

  LoadCartBloc(
    this.cartRepository,
    this.productRepository,
  ) : super(const LoadCartInitialState()) {
    on<OnLoadCartEvent>((event, emit) async {
      emit(LoadCartInitialState(
        cart: (state as LoadCartInitialState).cart,
        loading: true,
      ));

      final List<CartInput> cart = await cartRepository.cart;

      emit(LoadCartInitialState(
        cart: cart,
        loading: false,
      ));
    });
  }
}
