import "package:shop/entities/variant_entity.dart";

double minPrice(List<VariantEntity> products) {
  return double.parse(products
      .map<double>(
        (variant) {
          return variant.price;
        },
      )
      .reduce(
        (value, element) => value < element ? value : element,
      )
      .toStringAsFixed(2));
}

double? minPriceAfterDiscount(List<VariantEntity> products, double price) {
  double priceAfterDiscount = products.map<double>(
    (variant) {
      if (variant.priceAfterDiscount != null) {
        return variant.priceAfterDiscount!;
      }

      return variant.price;
    },
  ).reduce(
    (value, element) => value < element ? value : element,
  );

  return double.parse(priceAfterDiscount.toStringAsFixed(2)) == price
      ? null
      : double.parse(priceAfterDiscount.toStringAsFixed(2));
}
