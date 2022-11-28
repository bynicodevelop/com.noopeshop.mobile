import "package:hive/hive.dart";

part "product_input.g.dart";

@HiveType(typeId: 5)
class ProductInput {
  @HiveField(0)
  final int id;

  const ProductInput({
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
