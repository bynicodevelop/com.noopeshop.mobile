import "package:flutter_secure_storage/flutter_secure_storage.dart";

class SessionRepository {
  final FlutterSecureStorage storage;

  const SessionRepository(
    this.storage,
  );

  Future<void> setId(
    String id,
  ) async {
    await storage.write(
      key: "id",
      value: id,
    );
  }

  Future<void> getId() async => storage.read(
        key: "id",
      );

  Future<void> setEmail(
    String email,
  ) async =>
      storage.write(
        key: "email",
        value: email,
      );

  Future<String?> getEmail() async => storage.read(
        key: "email",
      );
}
