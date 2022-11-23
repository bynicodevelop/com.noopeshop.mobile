import "package:directus/directus.dart";
import "package:shop/entities/account_entity.dart";
import "package:shop/exceptions/account_exception.dart";
import "package:shop/models/account_model.dart";
import "package:shop/repositories/session_repository.dart";
import "package:shop/utils/logger.dart";

class AccountRepository {
  final Directus sdk;
  final SessionRepository sessionRepository;

  const AccountRepository(
    this.sdk,
    this.sessionRepository,
  );

  Future<AccountEntity?> create(
    AccountModel accountModel,
  ) async {
    final email = accountModel.email.trim().toLowerCase();
    final password = accountModel.password.trim();

    try {
      final DirectusResponse<DirectusUser> response = await sdk.users.createOne(
        DirectusUser(
          email: email,
          password: password,
        ),
      );

      await sessionRepository.setId(
        response.data.id!,
      );

      await sessionRepository.setEmail(
        response.data.email!,
      );

      return AccountEntity.fromJson(
        {
          "id": response.data.id,
          "email": response.data.email,
        },
      );
    } on DirectusError catch (e) {
      String code = "unknown";

      switch (e.code) {
        case 400:
          code = "user_already_exists";
          break;
        case 403:
          code = "permission_denied";
          break;
      }

      throw AccountException(
        e.message,
        code,
      );
    } catch (e) {
      error("AccountRepository.create", data: {
        "error": e.toString(),
      });
    }
    return null;
  }
}
