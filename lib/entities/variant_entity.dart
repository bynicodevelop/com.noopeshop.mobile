import "package:equatable/equatable.dart";
import "package:shop/entities/color_entity.dart";
import "package:shop/entities/size_entity.dart";

class VariantEntity extends Equatable {
  final String title;
  final int price;
  final int? priceAfterDiscount;
  final ColorEntity color;
  final SizeEntity size;

  const VariantEntity({
    required this.title,
    required this.price,
    required this.color,
    required this.size,
    this.priceAfterDiscount,
  });

  factory VariantEntity.fromJson(Map<String, dynamic> json) => VariantEntity(
        title: json["title"] as String,
        price: json["price"] as int,
        color: json["color"] as ColorEntity,
        size: json["size"] as SizeEntity,
        priceAfterDiscount: json["price_after_discount"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "color": color,
        "size": size,
        "price_after_discount": priceAfterDiscount,
      };

  @override
  List<Object?> get props => [
        title,
        price,
        color,
        size,
        priceAfterDiscount,
      ];
}
