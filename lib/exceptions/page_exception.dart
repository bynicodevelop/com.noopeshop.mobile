class PageException implements Exception {
  final String message;
  final String code;

  PageException(
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
