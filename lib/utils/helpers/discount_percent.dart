int? discountPercent(int? price, int? discount) {
  if (price == null || discount == null) return null;

  return ((discount / price) * 100).toInt();
}
