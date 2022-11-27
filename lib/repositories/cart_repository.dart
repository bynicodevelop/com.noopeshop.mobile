import "package:hive/hive.dart";
import "package:shop/entities/variant_entity.dart";

class CartRepository {
  late Box<List<VariantEntity>> cartBox;

  CartRepository(
    this.cartBox,
  );

  Future<void> addToCart(VariantEntity variant) async {
    final cart = cartBox.get("cart") ?? <VariantEntity>[];

    // Update variant if exists in cart
    final index = cart.indexWhere((element) => element.id == variant.id);

    if (index != -1) {
      cart[index] = variant;
    } else {
      cart.add(variant);
    }

    await cartBox.put("cart", cart);
  }
}
