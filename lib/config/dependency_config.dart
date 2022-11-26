import "package:dio/dio.dart";
import "package:directus/directus.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get_it/get_it.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";
import "package:shop/config/constants.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/repositories/bookmark_repository.dart";
import "package:shop/repositories/categories_repository.dart";
import "package:shop/repositories/pages_repository.dart";
import "package:shop/repositories/product_repository.dart";
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

  final BaseOptions options = BaseOptions(
    baseUrl: kEndpoint,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  final Dio dio = Dio(options);

  const FlutterSecureStorage storage = FlutterSecureStorage();

  const SessionRepository sessionRepository = SessionRepository(
    storage,
  );

  await Hive.initFlutter();

  final Box<List<int>> bookmarkBox = await Hive.openBox("bookmarks");

  final gh = GetItHelper(getIt, environment);

  gh.factory<SessionRepository>(
    () => const SessionRepository(
      storage,
    ),
  );

  gh.factory<AccountRepository>(
    () => AccountRepository(
      sdk,
      dio,
      sessionRepository,
    ),
  );

  gh.factory<CategoriesRepository>(
    () => CategoriesRepository(
      sdk,
    ),
  );

  gh.factory<ProductRepository>(
    () => ProductRepository(
      sdk,
      bookmarkBox,
    ),
  );

  gh.factory<PagesRepository>(
    () => PagesRepository(
      sdk,
    ),
  );

  gh.factory<BookmarkRepository>(
    () => BookmarkRepository(
      sdk,
      bookmarkBox,
    ),
  );
}
