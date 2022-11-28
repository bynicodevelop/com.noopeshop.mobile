double? discountPercent(double? price, double? discount) {
  if (price == null || discount == null) return null;

  return (discount / price) * 100;
}
