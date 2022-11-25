import "package:equatable/equatable.dart";
import "package:shop/entities/review_entity.dart";
import "package:shop/entities/variant_entity.dart";

class ProductEntity extends Equatable {
  final int id;
  final String thumbnail;
  final String brandName;
  final String title;
  final String productInfo;
  final String productDetails;
  final List<String> previews;
  final List<VariantEntity> variants;
  final List<ReviewEntity> reviews;
  final int price;
  final int? priceAfterDiscount;
  final int? dicountpercent;
  final bool sellWithoutStock;
  final int nbReviews;
  final double rating;

  const ProductEntity({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.productInfo,
    required this.productDetails,
    required this.brandName,
    required this.price,
    this.previews = const [],
    this.variants = const [],
    this.reviews = const [],
    this.priceAfterDiscount,
    this.dicountpercent,
    this.sellWithoutStock = false,
    this.nbReviews = 0,
    this.rating = 0,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
        id: json["id"] as int,
        thumbnail: json["thumbnail"] as String,
        brandName: json["brand_name"] as String,
        title: json["title"] as String,
        productInfo: json["product_info"] as String,
        productDetails: json["product_details"] as String,
        previews: json["previews"] as List<String>,
        variants: json["variantes"] as List<VariantEntity>,
        reviews: json["reviews"] as List<ReviewEntity>,
        price: json["price"] as int,
        priceAfterDiscount: json["price_after_discount"] as int?,
        dicountpercent: json["dicount_percent"] as int?,
        sellWithoutStock: json["sell_without_stock"] as bool,
        nbReviews: json["nb_reviews"] as int,
        rating: json["rating"] as double,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "brand_name": brandName,
        "title": title,
        "product_info": productInfo,
        "product_details": productDetails,
        "previews": previews,
        "variantes": variants,
        "reviews": reviews,
        "price": price,
        "price_after_discount": priceAfterDiscount,
        "dicountpercent": dicountpercent,
        "sell_without_stock": sellWithoutStock,
        "nb_reviews": nbReviews,
        "rating": rating,
      };

  @override
  List<Object?> get props => [
        id,
        thumbnail,
        brandName,
        title,
        productInfo,
        productDetails,
        previews,
        variants,
        reviews,
        price,
        priceAfterDiscount,
        dicountpercent,
        sellWithoutStock,
        nbReviews,
        rating,
      ];
}
