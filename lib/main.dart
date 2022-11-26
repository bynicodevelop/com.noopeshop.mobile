import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:shop/config/dependency_config.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/repositories/bookmark_repository.dart";
import "package:shop/repositories/categories_repository.dart";
import "package:shop/repositories/pages_repository.dart";
import "package:shop/repositories/product_repository.dart";
import "package:shop/repositories/session_repository.dart";
import "package:shop/route/route_constants.dart";
import "package:shop/route/router.dart" as router;
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:shop/services/service_factory.dart";

import "theme/dark_theme.dart";
import "theme/light_theme.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependancies(
    kDebugMode ? "development" : "production",
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ServiceFactory(
      getIt.get<AccountRepository>(),
      getIt.get<CategoriesRepository>(),
      getIt.get<ProductRepository>(),
      getIt.get<BookmarkRepository>(),
      getIt.get<PagesRepository>(),
      getIt.get<SessionRepository>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "The Flutter Way",
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en", ""),
          Locale("fr", ""),
        ],
        onGenerateRoute: router.generateRoute,
        initialRoute: entryPointScreenRoute,
      ),
    );
  }
}
