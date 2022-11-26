class ProductException implements Exception {
  final String message;
  final String code;

  ProductException(
    this.message,
    this.code,
  );

  @override
  String toString() {
    return {
      "message": message,
      "code": code,
    }.toString();
  }
}
