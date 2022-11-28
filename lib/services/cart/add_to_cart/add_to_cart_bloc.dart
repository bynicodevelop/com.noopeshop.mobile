import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/inputs/cart_input.dart";
import "package:shop/repositories/cart_repository.dart";

part "add_to_cart_event.dart";
part "add_to_cart_state.dart";

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final CartRepository cartRepository;

  AddToCartBloc(
    this.cartRepository,
  ) : super(AddToCartInitialState()) {
    on<OnAddToCartEvent>((event, emit) async {
      emit(AddToCartLoadingState());

      try {
        await cartRepository.addToCart(
          event.variant,
        );

        emit(AddToCartSuccessState());
      } catch (e) {
        print(e);
        emit(AddToCartFailureState(
          e.toString(),
        ));
      }
    });
  }
}
