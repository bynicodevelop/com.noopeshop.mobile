import "package:dio/dio.dart";
import "package:directus/directus.dart";
import "package:shop/entities/account_entity.dart";
import "package:shop/exceptions/account_exception.dart";
import "package:shop/inputs/login_input.dart";
import "package:shop/models/account_model.dart";
import "package:shop/repositories/session_repository.dart";
import "package:shop/utils/logger.dart";

class AccountRepository {
  final Directus sdk;
  final Dio dio;
  final SessionRepository sessionRepository;

  const AccountRepository(
    this.sdk,
    this.dio,
    this.sessionRepository,
  );

  bool get isAuthenticated => sdk.auth.isLoggedIn;

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

  Future<void> validateEmail(
    String code,
  ) async {
    try {
      await dio.post(
        "/validate-account",
        data: {
          "account_code": code,
          "id": await sessionRepository.getId(),
        },
      );
    } on DioError catch (e) {
      throw AccountException(
        "An error occured",
        e.response!.data["code"],
      );
    }
  }

  Future<void> login(LoginInput loginInput) async {
    final email = loginInput.email.trim().toLowerCase();
    final password = loginInput.password.trim();

    try {
      await sdk.auth.login(
        email: email,
        password: password,
      );

      final DirectusResponse<DirectusUser>? user =
          await sdk.auth.currentUser?.read();

      print(user!.data.id);
    } on DirectusError catch (e) {
      String code = "unknown";

      switch (e.code) {
        case 400:
          code = "invalid_credentials";
          break;
        case 403:
          code = "permission_denied";
          break;
      }

      if (e.message.contains("email")) {
        code = "invalid_email";
      }

      throw AccountException(
        e.message,
        code,
      );
    } catch (e) {
      error("AccountRepository.login", data: {
        "error": e.toString(),
      });
    }
  }

  Future<void> logout() async => await sdk.auth.logout();
}
