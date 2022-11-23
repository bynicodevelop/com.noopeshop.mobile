import "package:directus/directus.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get_it/get_it.dart";
import "package:injectable/injectable.dart";
import "package:shop/config/constants.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/repositories/session_repository.dart";

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r"$initGetIt",
)
Future<void> configureDependancies(
  String environment,
) async =>
    $initGetIt(
      getIt,
      environment: environment,
    );

$initGetIt(
  GetIt getIt, {
  required String environment,
  EnvironmentFilter? environmentFilter,
}) async {
  final Directus sdk = await Directus(kEndpoint).init();

  const FlutterSecureStorage storage = FlutterSecureStorage();

  const SessionRepository sessionRepository = SessionRepository(
    storage,
  );

  final gh = GetItHelper(getIt, environment);

  gh.factory<AccountRepository>(
    () => AccountRepository(
      sdk,
      sessionRepository,
    ),
  );
}
