part of "add_to_cart_bloc.dart";

abstract class AddToCartEvent extends Equatable {
  const AddToCartEvent();

  @override
  List<Object> get props => [];
}

class OnAddToCartEvent extends AddToCartEvent {
  final CartInput variant;

  const OnAddToCartEvent({
    required this.variant,
  });

  @override
  List<Object> get props => [
        variant,
      ];
}
