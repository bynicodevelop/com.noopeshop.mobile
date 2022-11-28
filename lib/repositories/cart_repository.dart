import "package:hive/hive.dart";
import "package:shop/inputs/cart_input.dart";

class CartRepository {
  late Box<List<dynamic>> cartBox;

  CartRepository(
    this.cartBox,
  );

  Future<List<CartInput>> get cart async =>
      List<CartInput>.from(List<dynamic>.from(cartBox.get("cart") ?? []));

  Future<void> addToCart(CartInput cartInput) async {
    final cart = cartBox.get("cart") ?? <CartInput>[];

    final int index = cart.indexWhere(
      (element) => element.variant.id == cartInput.variant.id,
    );

    if (index != -1) {
      cart[index] = cartInput;
    } else {
      cart.add(cartInput);
    }

    await cartBox.put("cart", cart);
  }
}
