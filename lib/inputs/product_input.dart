import "package:hive/hive.dart";

part "product_input.g.dart";

@HiveType(typeId: 5)
class ProductInput {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? brandName;

  const ProductInput({
    required this.id,
    this.title,
    this.brandName,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "brand_name": brandName,
      };
}
