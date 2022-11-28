import "package:equatable/equatable.dart";
import "package:hive/hive.dart";
import "package:shop/entities/color_entity.dart";
import "package:shop/entities/size_entity.dart";

part "variant_entity.g.dart";

@HiveType(typeId: 0)
class VariantEntity extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String thumbnail;

  @HiveField(3)
  final int price;

  @HiveField(4)
  final int? priceAfterDiscount;

  @HiveField(5)
  final ColorEntity color;

  @HiveField(6)
  final SizeEntity size;

  @HiveField(7)
  final int productId;

  const VariantEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.color,
    required this.size,
    required this.productId,
    this.priceAfterDiscount,
  });

  factory VariantEntity.fromJson(Map<String, dynamic> json) => VariantEntity(
        id: json["id"],
        title: json["title"] as String,
        thumbnail: json["thumbnail"] as String,
        price: json["price"] as int,
        color: json["color"] as ColorEntity,
        size: json["size"] as SizeEntity,
        productId: json["product_id"] as int,
        priceAfterDiscount: json["price_after_discount"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "price": price,
        "color": color,
        "size": size,
        "product_id": productId,
        "price_after_discount": priceAfterDiscount,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        thumbnail,
        price,
        color,
        size,
        productId,
        priceAfterDiscount,
      ];
}
