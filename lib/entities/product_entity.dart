import "package:equatable/equatable.dart";
import "package:shop/entities/variant_entity.dart";

class ProductEntity extends Equatable {
  final String thumbnail;
  final String brandName;
  final String title;
  final List<String> previews;
  final List<VariantEntity> variants;
  final int price;
  final int? priceAfterDiscount;
  final int? dicountpercent;

  const ProductEntity({
    required this.thumbnail,
    required this.title,
    required this.brandName,
    required this.price,
    this.previews = const [],
    this.variants = const [],
    this.priceAfterDiscount,
    this.dicountpercent,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
        thumbnail: json["thumbnail"] as String,
        brandName: json["brand_name"] as String,
        title: json["title"] as String,
        previews: json["previews"] as List<String>,
        variants: json["variantes"] as List<VariantEntity>,
        price: json["price"] as int,
        priceAfterDiscount: json["price_after_discount"] as int?,
        dicountpercent: json["dicount_percent"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "brand_name": brandName,
        "title": title,
        "previews": previews,
        "variantes": variants,
        "price": price,
        "price_after_discount": priceAfterDiscount,
        "dicountpercent": dicountpercent,
      };

  @override
  List<Object?> get props => [
        thumbnail,
        brandName,
        title,
        previews,
        variants,
        price,
        priceAfterDiscount,
        dicountpercent,
      ];
}
