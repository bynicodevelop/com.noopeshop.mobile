import "package:directus/directus.dart";
import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:shop/entities/color_entity.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/entities/review_entity.dart";
import "package:shop/entities/size_entity.dart";
import "package:shop/entities/variant_entity.dart";
import "package:shop/entities/vat_entity.dart";
import "package:shop/exceptions/product_exception.dart";
import "package:shop/inputs/product_input.dart";
import "package:shop/utils/filters/min_price.dart";
import "package:shop/utils/helpers/average_rating.dart";
import "package:shop/utils/helpers/discount_percent.dart";

class ProductRepository {
  final Directus sdk;
  final Box<List<dynamic>> bookmarkBox;

  final List<ProductEntity> _products = [];

  ProductRepository(
    this.sdk,
    this.bookmarkBox,
  );

  Future<List<ProductEntity>> getLatestProducts() async {
    _products.clear();

    final List<ProductInput> bookmarks = List<ProductInput>.from(
        List<dynamic>.from(bookmarkBox.get("bookmarks") ?? []));

    // try {
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
              price: productData["price"] as double,
              priceAfterDiscount:
                  productData["price_after_discount"] as double?,
              dicountpercent: productData["discount_percent"] as double?,
              sellWithoutStock: productData["sell_without_stock"] as bool,
              nbReviews: productData["nb_reviews"] as int,
              rating: productData["rating"] as double,
              isBookmarked:
                  bookmarks.any((bookmark) => bookmark.id == productData["id"]),
            );
          },
        )
        .where((element) => element.variants.isNotEmpty)
        .toList());

    return _products;
    // } on DirectusError catch (e) {
    //   String code = "unknown";

    //   switch (e.code) {
    //     case 403:
    //       code = "permission_denied";
    //       break;
    //   }

    //   throw ProductException(
    //     e.message,
    //     code,
    //   );
    // } catch (e) {
    //   throw ProductException(
    //     e.toString(),
    //     "unknown",
    //   );
    // }
  }

  Future<ProductEntity> loadProduct(int productId) async {
    final List<ProductInput> bookmarks = List<ProductInput>.from(
        List<dynamic>.from(bookmarkBox.get("bookmarks") ?? []));
    late ProductEntity product;

    final bool isBookmarked =
        bookmarks.any((bookmark) => bookmark.id == productId);

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
        price: productData["price"] as double,
        priceAfterDiscount: productData["price_after_discount"] as double?,
        dicountpercent: productData["discount_percent"] as double?,
        sellWithoutStock: productData["sell_without_stock"] as bool,
        nbReviews: productData["nb_reviews"] as int,
        rating: productData["rating"] as double,
        isBookmarked: isBookmarked,
      );
    }

    final DirectusListResponse<Map<String, dynamic>> response =
        await sdk.items("products").readMany(
              query: Query(
                fields: [
                  "id",
                  "related_products.*.*",
                  "related_products.*.variantes.*.*.*",
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
          price: productData["price"] as double,
          priceAfterDiscount: productData["priceAfterDiscount"] as double?,
          dicountpercent: productData["dicountpercent"] as double?,
          sellWithoutStock: productData["sell_without_stock"] as bool,
          nbReviews: productData["nb_reviews"] as int,
          rating: productData["rating"] as double,
        );

        relatedProductsData.add(productEntity);
      }
    }

    return product.copyWith(
      relatedProducts: relatedProductsData,
      isBookmarked: isBookmarked,
    );
  }

  Future<List<ProductEntity>> getProductFromListIds() async {
    final List<ProductEntity> products = [];
    final List<ProductInput> productInputList = List<ProductInput>.from(
        List<dynamic>.from(bookmarkBox.get("bookmarks") ?? []));

    final List<int> productIds = productInputList.map((e) => e.id).toList();

    if (productIds.isEmpty) return products;

    // try {
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
                  "variantes.*.*.*",
                  "reviews.*",
                ],
                sort: [
                  "-date_created",
                ],
              ),
              filters: Filters({
                "status": Filter.eq("published"),
                "id": Filter.isIn(productIds),
              }),
            );

    for (final productData in response.data) {
      Map<String, dynamic> productDataFormatted = _formatProductData(
        productData,
      );

      final ProductEntity product = ProductEntity(
        id: productDataFormatted["id"] as int,
        thumbnail: productDataFormatted["thumbnail"] as String,
        title: productDataFormatted["title"] as String,
        productInfo: productDataFormatted["product_info"] as String,
        productDetails: productDataFormatted["product_details"] as String,
        brandName: productDataFormatted["brand_name"] as String,
        previews: productDataFormatted["previews"] as List<String>,
        variants: productDataFormatted["variantes"] as List<VariantEntity>,
        reviews: productDataFormatted["reviews"] as List<ReviewEntity>,
        relatedProducts: const [],
        price: productDataFormatted["price"] as double,
        priceAfterDiscount:
            productDataFormatted["price_after_discount"] as double?,
        dicountpercent: productDataFormatted["discount_percent"] as double?,
        sellWithoutStock: productDataFormatted["sell_without_stock"] as bool,
        nbReviews: productDataFormatted["nb_reviews"] as int,
        rating: productDataFormatted["rating"] as double,
        isBookmarked: true,
      );

      products.add(product);
    }

    return products;
    // } catch (e) {
    //   throw ProductException(
    //     e.toString(),
    //     "unknown",
    //   );
    // }
  }

  Future<List<Map<String, dynamic>>> _getProductsData(
    int? productDataId,
  ) async {
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
                  "variantes.*.*.*",
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

  double _vatPrice(variant) {
    return variant["vat"]["value"] > 0
        ? variant["price"] / 100 +
            (variant["price"] /
                100 *
                double.parse(variant["vat"]["value"].toString()) /
                100)
        : variant["price"] / 100;
  }

  double _vatPriceAmount(variant) {
    return variant["vat"]["value"] > 0
        ? variant["price"] /
            100 *
            double.parse(variant["vat"]["value"].toString()) /
            100
        : 0;
  }

  double _vatPriceAfterDiscount(variant) {
    return variant["vat"]["value"] > 0
        ? variant["price_after_discount"] / 100 +
            (variant["price_after_discount"] /
                100 *
                double.parse(variant["vat"]["value"].toString()) /
                100)
        : variant["price_after_discount"] / 100;
  }

  double _vatPriceAfterDiscountAmount(variant) {
    return variant["vat"]["value"] > 0
        ? variant["price_after_discount"] /
            100 *
            double.parse(variant["vat"]["value"].toString()) /
            100
        : 0;
  }

  Map<String, dynamic> _formatProductData(Map<String, dynamic> productData) {
    List<VariantEntity> variants = [];
    List<String> previews = [];
    List<ReviewEntity> reviews = [];

    if (productData["variantes"] != null) {
      variants =
          List<dynamic>.from(productData["variantes"]).map<VariantEntity>(
        (variant) {
          return VariantEntity.fromJson({
            ...variant,
            "price": _vatPrice(variant),
            "price_vat": _vatPriceAmount(variant),
            "price_after_discount": variant["price_after_discount"] != null
                ? _vatPriceAfterDiscount(variant)
                : null,
            "price_after_discount_vat": variant["price_after_discount"] != null
                ? _vatPriceAfterDiscountAmount(variant)
                : null,
            "thumbnail": variant["thumbnail"] != null
                ? variant["thumbnail"]["id"]
                : null,
            "product_id": productData["id"],
            "color": ColorEntity(
              slug: variant["colors"].first["colors_id"]["slug"],
              value: Color(int.parse(
                  variant["colors"].first["colors_id"]["value"].replaceAll(
                        "#",
                        "0xff",
                      ))),
            ),
            "size": SizeEntity(
              slug: variant["sizes"].first["sizes_id"]["slug"],
              value: variant["sizes"].first["sizes_id"]["value"],
            ),
            "vat_rate": VatEntity(
              id: variant["vat"]["id"],
              label: variant["vat"]["label"],
              value: double.parse(variant["vat"]["value"].toString()),
            ),
          });
        },
      ).toList();
    }

    double price = 0;
    double? priceAfterDiscount = 0;
    double? discount = 0;

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
      "discount_percent": discount,
      "sell_without_stock": productData["sell_without_stock"],
      "nb_reviews": reviews.length,
      "rating": averageRating(reviews),
    };
  }
}
