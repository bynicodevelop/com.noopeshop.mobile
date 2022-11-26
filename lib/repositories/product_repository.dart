import "package:directus/directus.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/entities/review_entity.dart";
import "package:shop/entities/variant_entity.dart";
import "package:shop/exceptions/product_exception.dart";
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
    try {
      final List<Map<String, dynamic>> responses = await _getProductsData(null);

      _products.addAll(responses
          .map(
            (product) {
              Map<String, dynamic> productData = _formatProductData(product);

              return ProductEntity(
                id: productData["id"] as int,
                thumbnail: productData["thumbnail"] as String,
                title: productData["title"] as String,
                productInfo: productData["product_info"] as String,
                productDetails: productData["product_details"] as String,
                brandName: productData["brand_name"] as String,
                previews: productData["previews"] as List<String>,
                variants: productData["variantes"] as List<VariantEntity>,
                reviews: productData["reviews"] as List<ReviewEntity>,
                relatedProducts: const [],
                price: productData["price"] as int,
                priceAfterDiscount: productData["price_after_discount"] as int?,
                dicountpercent: productData["discount_percent"] as int?,
                sellWithoutStock: productData["sell_without_stock"] as bool,
                nbReviews: productData["nb_reviews"] as int,
                rating: productData["rating"] as double,
              );
            },
          )
          .where((element) => element.variants.isNotEmpty)
          .toList());

      return _products;
    } on DirectusError catch (e) {
      String code = "unknown";

      switch (e.code) {
        case 403:
          code = "permission_denied";
          break;
      }

      throw ProductException(
        e.message,
        code,
      );
    } catch (e) {
      throw ProductException(
        e.toString(),
        "unknown",
      );
    }
  }

  Future<ProductEntity> loadProduct(int productId) async {
    late ProductEntity product;

    try {
      product = _products.firstWhere(
        (element) => element.id == productId,
      );
    } catch (e) {
      final List<Map<String, dynamic>> responses =
          await _getProductsData(productId);

      if (responses.isEmpty) {
        throw ProductException(
          "Product not found",
          "product_not_found",
        );
      }

      Map<String, dynamic> productData = _formatProductData(
        responses.first,
      );

      product = ProductEntity(
        id: productData["id"] as int,
        thumbnail: productData["thumbnail"] as String,
        title: productData["title"] as String,
        productInfo: productData["product_info"] as String,
        productDetails: productData["product_details"] as String,
        brandName: productData["brand_name"] as String,
        previews: productData["previews"] as List<String>,
        variants: productData["variantes"] as List<VariantEntity>,
        reviews: productData["reviews"] as List<ReviewEntity>,
        relatedProducts: const [],
        price: productData["price"] as int,
        priceAfterDiscount: productData["price_after_discount"] as int?,
        dicountpercent: productData["discount_percent"] as int?,
        sellWithoutStock: productData["sell_without_stock"] as bool,
        nbReviews: productData["nb_reviews"] as int,
        rating: productData["rating"] as double,
      );
    }

    final DirectusListResponse<Map<String, dynamic>> response =
        await sdk.items("products").readMany(
              query: Query(
                fields: [
                  "id",
                  "related_products.*.*",
                  "related_products.*.variantes.*",
                  "related_products.*.reviews.*",
                  "related_products.*.previews.directus_files_id",
                ],
                sort: [
                  "-date_created",
                ],
              ),
              filters: Filters({
                "status": Filter.eq("published"),
                "id": Filter.eq(productId),
              }),
            );

    final List<ProductEntity> relatedProductsData = [];

    if (response.data.isNotEmpty) {
      final List<dynamic> relatedProducts =
          response.data.first["related_products"];

      for (final relatedProduct in relatedProducts) {
        final Map<String, dynamic> productRelated = Map<String, dynamic>.from(
          relatedProduct["related_products_id"],
        );

        Map<String, dynamic> productData = _formatProductData(productRelated);

        final ProductEntity productEntity = ProductEntity(
          id: productData["id"] as int,
          thumbnail: productData["thumbnail"] as String,
          title: productData["title"] as String,
          productInfo: productData["product_info"] as String,
          productDetails: productData["product_details"] as String,
          brandName: productData["brand_name"] as String,
          previews: productData["previews"] as List<String>,
          variants: productData["variantes"] as List<VariantEntity>,
          reviews: productData["reviews"] as List<ReviewEntity>,
          relatedProducts: const [],
          price: productData["price"] as int,
          priceAfterDiscount: productData["priceAfterDiscount"] as int?,
          dicountpercent: productData["dicountpercent"] as int?,
          sellWithoutStock: productData["sell_without_stock"] as bool,
          nbReviews: productData["nb_reviews"] as int,
          rating: productData["rating"] as double,
        );

        relatedProductsData.add(productEntity);
      }
    }

    return product.copyWith(
      relatedProducts: relatedProductsData,
    );
  }

  Future<List<Map<String, dynamic>>> _getProductsData(
      int? productDataId) async {
    final Map<String, Filter> filters = {
      "status": Filter.eq("published"),
    };

    if (productDataId != null) {
      filters["id"] = Filter.eq(productDataId);
    }

    final DirectusListResponse<Map<String, dynamic>> response =
        await sdk.items("products").readMany(
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
                  "reviews.*",
                ],
                sort: [
                  "-date_created",
                ],
              ),
              filters: Filters(filters),
            );

    return response.data;
  }

  Map<String, dynamic> _formatProductData(Map<String, dynamic> productData) {
    List<VariantEntity> variants = [];
    List<String> previews = [];
    List<ReviewEntity> reviews = [];

    if (productData["variantes"] != null) {
      variants = List<dynamic>.from(productData["variantes"])
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

    if (productData["previews"] != null) {
      previews = List<dynamic>.from(productData["previews"])
          .map<String>(
            (preview) => preview["directus_files_id"],
          )
          .toList();
    }

    if (productData["reviews"] != null) {
      reviews = List<dynamic>.from(productData["reviews"])
          .map<ReviewEntity>(
            (review) => ReviewEntity.fromJson(review),
          )
          .toList();
    }

    return {
      "id": productData["id"],
      "thumbnail": productData["thumbnail"],
      "title": productData["title"],
      "product_info": productData["product_info"],
      "product_details": productData["product_details"],
      "brand_name": productData["brand_name"],
      "previews": previews,
      "variantes": variants,
      "reviews": reviews,
      "related_products": const [],
      "price": price,
      "price_after_discount": priceAfterDiscount,
      "dicountpercent": discount,
      "sell_without_stock": productData["sell_without_stock"],
      "nb_reviews": reviews.length,
      "rating": averageRating(reviews),
    };
  }
}
