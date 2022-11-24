import "package:shop/entities/variant_entity.dart";

int minPrice(List<VariantEntity> products) {
  return products
      .map<int>(
        (variant) => variant.price,
      )
      .reduce(
        (value, element) => value < element ? value : element,
      );
}

int? minPriceAfterDiscount(List<VariantEntity> products, int price) {
  int priceAfterDiscount = products.map<int>(
    (variant) {
      if (variant.priceAfterDiscount != null) {
        return variant.priceAfterDiscount!;
      }

      return variant.price;
    },
  ).reduce(
    (value, element) => value < element ? value : element,
  );

  return priceAfterDiscount == price ? null : priceAfterDiscount;
}
