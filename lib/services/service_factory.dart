import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/repositories/categories_repository.dart";
import "package:shop/repositories/product_repository.dart";
import "package:shop/repositories/session_repository.dart";
import "package:shop/services/accounts/create/create_account_bloc.dart";
import "package:shop/services/accounts/validate/validate_account_bloc.dart";
import "package:shop/services/categories/load/load_categories_bloc.dart";
import "package:shop/services/products/load_latest_products/load_latest_products_bloc.dart";
import "package:shop/services/session/load/load_session_bloc.dart";

class ServiceFactory extends StatelessWidget {
  final AccountRepository accountRepository;
  final CategoriesRepository categoriesRepository;
  final ProductRepository productRepository;
  final SessionRepository sessionRepository;

  final Widget child;

  const ServiceFactory(
    this.accountRepository,
    this.categoriesRepository,
    this.productRepository,
    this.sessionRepository, {
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoadSessionBloc>(
          create: (context) => LoadSessionBloc(
            sessionRepository,
          ),
        ),
        BlocProvider<CreateAccountBloc>(
          create: (context) => CreateAccountBloc(
            accountRepository,
          ),
        ),
        BlocProvider<ValidateAccountBloc>(
          create: (context) => ValidateAccountBloc(
            accountRepository,
          ),
        ),
        BlocProvider<LoadCategoriesBloc>(
          create: (context) => LoadCategoriesBloc(
            categoriesRepository,
          ),
        ),
        BlocProvider<LoadLatestProductsBloc>(
          create: (context) => LoadLatestProductsBloc(
            productRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
