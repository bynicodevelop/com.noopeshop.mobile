part of "add_to_cart_bloc.dart";

abstract class AddToCartEvent extends Equatable {
  const AddToCartEvent();

  @override
  List<Object> get props => [];
}

class OnAddToCartEvent extends AddToCartEvent {
  final VariantEntity variant;
  final int quantity;

  const OnAddToCartEvent({
    required this.variant,
    required this.quantity,
  });

  @override
  List<Object> get props => [
        variant,
        quantity,
      ];
}
