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
  final List<ProductEntity> relatedProducts;
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
    this.relatedProducts = const [],
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
        relatedProducts: json["related_products"] as List<ProductEntity>,
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
        "related_products": relatedProducts,
        "price": price,
        "price_after_discount": priceAfterDiscount,
        "dicountpercent": dicountpercent,
        "sell_without_stock": sellWithoutStock,
        "nb_reviews": nbReviews,
        "rating": rating,
      };

  ProductEntity copyWith({
    int? id,
    String? thumbnail,
    String? brandName,
    String? title,
    String? productInfo,
    String? productDetails,
    List<String>? previews,
    List<VariantEntity>? variants,
    List<ReviewEntity>? reviews,
    List<ProductEntity>? relatedProducts,
    int? price,
    int? priceAfterDiscount,
    int? dicountpercent,
    bool? sellWithoutStock,
    int? nbReviews,
    double? rating,
  }) =>
      ProductEntity(
        id: id ?? this.id,
        thumbnail: thumbnail ?? this.thumbnail,
        brandName: brandName ?? this.brandName,
        title: title ?? this.title,
        productInfo: productInfo ?? this.productInfo,
        productDetails: productDetails ?? this.productDetails,
        previews: previews ?? this.previews,
        variants: variants ?? this.variants,
        reviews: reviews ?? this.reviews,
        relatedProducts: relatedProducts ?? this.relatedProducts,
        price: price ?? this.price,
        priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
        dicountpercent: dicountpercent ?? this.dicountpercent,
        sellWithoutStock: sellWithoutStock ?? this.sellWithoutStock,
        nbReviews: nbReviews ?? this.nbReviews,
        rating: rating ?? this.rating,
      );

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
        relatedProducts,
        price,
        priceAfterDiscount,
        dicountpercent,
        sellWithoutStock,
        nbReviews,
        rating,
      ];
}
