import "package:directus/directus.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/entities/review_entity.dart";
import "package:shop/entities/variant_entity.dart";
import "package:shop/utils/filters/min_price.dart";
import "package:shop/utils/helpers/average_rating.dart";
import "package:shop/utils/helpers/discount_percent.dart";

class ProductRepository {
  final Directus sdk;

  final List<ProductEntity> _products = [];

  ProductRepository(
    this.sdk,
  );

  Future<List<ProductEntity>> getLatestProducts() async {
    final response = await sdk.items("products").readMany(
          query: Query(
            fields: [
              "id",
              "thumbnail",
              "title",
              "product_info",
              "product_details",
              "brand_name",
              "previews.directus_files_id",
              "sell_without_stock",
              "variantes.*",
              "reviews.*"
            ],
            sort: [
              "-date_created",
            ],
          ),
          filters: Filters({
            "status": Filter.eq("published"),
          }),
        );

    _products.addAll(response.data
        .map(
          (product) {
            List<VariantEntity> variants = [];
            List<String> previews = [];
            List<ReviewEntity> reviews = [];

            if (product["variantes"] != null) {
              variants = List<dynamic>.from(product["variantes"])
                  .map<VariantEntity>(
                    (variant) => VariantEntity.fromJson(variant),
                  )
                  .toList();
            }

            int price = 0;
            int? priceAfterDiscount = 0;
            int? discount = 0;

            if (variants.isNotEmpty) {
              price = minPrice(variants);
              priceAfterDiscount = minPriceAfterDiscount(variants, price);
              discount = discountPercent(price, priceAfterDiscount);
            }

            if (product["previews"] != null) {
              previews = List<dynamic>.from(product["previews"])
                  .map<String>(
                    (preview) => preview["directus_files_id"],
                  )
                  .toList();
            }

            if (product["reviews"] != null) {
              reviews = List<dynamic>.from(product["reviews"])
                  .map<ReviewEntity>(
                    (review) => ReviewEntity.fromJson(review),
                  )
                  .toList();
            }

            return ProductEntity(
              id: product["id"] as int,
              thumbnail: product["thumbnail"] as String,
              title: product["title"] as String,
              productInfo: product["product_info"] as String,
              productDetails: product["product_details"] as String,
              brandName: product["brand_name"] as String,
              previews: previews,
              variants: variants,
              reviews: reviews,
              price: price,
              priceAfterDiscount: priceAfterDiscount,
              dicountpercent: discount,
              sellWithoutStock: product["sell_without_stock"] as bool,
              nbReviews: reviews.length,
              rating: averageRating(reviews),
            );
          },
        )
        .where((element) => element.variants.isNotEmpty)
        .toList());

    return _products;
  }

  Future<ProductEntity> loadProduct(int productId) async {
    return _products.firstWhere(
      (element) => element.id == productId,
    );
  }
}
