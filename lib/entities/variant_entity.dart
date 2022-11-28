import "package:equatable/equatable.dart";
import "package:hive/hive.dart";
import "package:shop/entities/color_entity.dart";
import "package:shop/entities/size_entity.dart";
import "package:shop/entities/vat_entity.dart";

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
  final double price;

  @HiveField(4)
  final double priceVat;

  @HiveField(5)
  final VatEntity vatRat;

  @HiveField(6)
  final double? priceAfterDiscount;

  @HiveField(7)
  final double? priceAfterDiscountVat;

  @HiveField(8)
  final ColorEntity color;

  @HiveField(9)
  final SizeEntity size;

  @HiveField(10)
  final int productId;

  const VariantEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.priceVat,
    required this.vatRat,
    required this.color,
    required this.size,
    required this.productId,
    this.priceAfterDiscount,
    this.priceAfterDiscountVat,
  });

  factory VariantEntity.fromJson(Map<String, dynamic> json) => VariantEntity(
        id: json["id"],
        title: json["title"] as String,
        thumbnail: json["thumbnail"] as String,
        price: json["price"] as double,
        priceVat: json["price_vat"] as double,
        vatRat: json["vat_rate"] as VatEntity,
        color: json["color"] as ColorEntity,
        size: json["size"] as SizeEntity,
        productId: json["product_id"] as int,
        priceAfterDiscount: json["price_after_discount"] as double?,
        priceAfterDiscountVat: json["price_after_discount_vat"] as double?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "price": price,
        "price_vat": priceVat,
        "vat_rate": vatRat.toJson(),
        "color": color,
        "size": size,
        "product_id": productId,
        "price_after_discount": priceAfterDiscount,
        "price_after_discount_vat": priceAfterDiscountVat,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        thumbnail,
        price,
        priceVat,
        vatRat,
        color,
        size,
        productId,
        priceAfterDiscount,
        priceAfterDiscountVat,
      ];
}
