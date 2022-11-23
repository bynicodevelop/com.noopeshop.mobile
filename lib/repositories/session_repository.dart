import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:shop/entities/session_entity.dart";

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

  Future<String?> getId() async => storage.read(
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

  Future<SessionEntity> getSession() async {
    final id = await getId();
    final email = await getEmail();

    if (id == null || email == null) {
      throw Exception("Session not found");
    }

    return SessionEntity(
      id: id,
      email: email,
    );
  }
}
