import "package:directus/directus.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/entities/variant_entity.dart";
import "package:shop/utils/filters/min_price.dart";
import "package:shop/utils/helpers/discount_percent.dart";

class ProductRepository {
  final Directus sdk;

  const ProductRepository(
    this.sdk,
  );

  Future<List<ProductEntity>> getLatestProducts() async {
    final response = await sdk.items("products").readMany(
          query: Query(
            fields: [
              "id",
              "thumbnail",
              "title",
              "brand_name",
              "previews.directus_files_id",
              "variantes.*",
            ],
          ),
          filters: Filters({
            "status": Filter.eq("published"),
          }),
        );

    return response.data
        .map(
          (product) {
            List<VariantEntity> variants = [];
            List<String> previews = [];

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
              previews = List<dynamic>.from(product["previews"]).map<String>(
                (preview) {
                  return preview["directus_files_id"];
                },
              ).toList();
            }

            return ProductEntity(
              thumbnail: product["thumbnail"] as String,
              title: product["title"] as String,
              brandName: product["brand_name"] as String,
              previews: previews,
              variants: variants,
              price: price,
              priceAfterDiscount: priceAfterDiscount,
              dicountpercent: discount,
            );
          },
        )
        .where((element) => element.variants.isNotEmpty)
        .toList();
  }
}
