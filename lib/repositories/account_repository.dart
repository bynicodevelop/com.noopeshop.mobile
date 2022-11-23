import "package:directus/directus.dart";
import "package:shop/models/account_model.dart";

class AccountRepository {
  final Directus sdk;

  const AccountRepository(
    this.sdk,
  );

  Future<void> create(AccountModel accountModel) async {}
}
