class AccountException implements Exception {
  final String message;
  final String code;

  AccountException(
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
