import "package:directus/directus.dart";
import "package:shop/entities/account_entity.dart";
import "package:shop/models/account_model.dart";

class AccountRepository {
  final Directus sdk;

  const AccountRepository(
    this.sdk,
  );

  Future<AccountEntity> create(AccountModel accountModel) async {
    return AccountEntity.fromJson(
      {
        "id": "1",
        "email": accountModel.email,
      },
    );
  }
}
