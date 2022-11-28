import "package:shop/inputs/cart_input.dart";

double total(List<CartInput> cart) {
  double total = 0.0;

  for (var element in cart) {
    if (element.variant.priceAfterDiscount != null) {
      total += element.variant.priceAfterDiscount! * element.quantity;
    } else {
      total += element.variant.price * element.quantity;
    }
  }

  return total;
}
