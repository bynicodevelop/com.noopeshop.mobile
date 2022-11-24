import "package:equatable/equatable.dart";

class VariantEntity extends Equatable {
  final String title;
  final int price;
  final int? priceAfterDiscount;

  const VariantEntity({
    required this.title,
    required this.price,
    this.priceAfterDiscount,
  });

  factory VariantEntity.fromJson(Map<String, dynamic> json) => VariantEntity(
        title: json["title"] as String,
        price: json["price"] as int,
        priceAfterDiscount: json["price_after_discount"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "price_after_discount": priceAfterDiscount,
      };

  @override
  List<Object?> get props => [
        title,
        price,
        priceAfterDiscount,
      ];
}
