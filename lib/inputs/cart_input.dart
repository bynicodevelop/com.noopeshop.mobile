import "package:equatable/equatable.dart";
import "package:hive/hive.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/entities/variant_entity.dart";

part "cart_input.g.dart";

@HiveType(typeId: 4)
class CartInput extends Equatable {
  @HiveField(0)
  final VariantEntity variant;

  @HiveField(1)
  final ProductEntity product;

  @HiveField(2)
  final int quantity;

  const CartInput({
    required this.variant,
    required this.product,
    required this.quantity,
  });

  @override
  List<Object> get props => [
        variant,
        product,
        quantity,
      ];
}
