import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/repositories/bookmark_repository.dart";
import "package:shop/repositories/cart_repository.dart";
import "package:shop/repositories/categories_repository.dart";
import "package:shop/repositories/pages_repository.dart";
import "package:shop/repositories/product_repository.dart";
import "package:shop/repositories/session_repository.dart";
import "package:shop/services/accounts/auth_state/auth_state_bloc.dart";
import "package:shop/services/accounts/create/create_account_bloc.dart";
import "package:shop/services/accounts/login/login_bloc.dart";
import "package:shop/services/accounts/logout/logout_bloc.dart";
import "package:shop/services/accounts/validate/validate_account_bloc.dart";
import "package:shop/services/bookmark/add_bookmark/add_bookmark_bloc.dart";
import "package:shop/services/bookmark/load_bookmark/load_bookmark_bloc.dart";
import "package:shop/services/cart/add_to_cart/add_to_cart_bloc.dart";
import "package:shop/services/cart/load_cart/load_cart_bloc.dart";
import "package:shop/services/categories/load/load_categories_bloc.dart";
import "package:shop/services/pages/load_page/load_page_bloc.dart";
import "package:shop/services/products/load_latest_products/load_latest_products_bloc.dart";
import "package:shop/services/products/load_product_by_id/load_product_by_id_bloc.dart";
import "package:shop/services/reviews/sort_reviews/sort_reviews_bloc.dart";
import "package:shop/services/session/load/load_session_bloc.dart";

class ServiceFactory extends StatelessWidget {
  final AccountRepository accountRepository;
  final CategoriesRepository categoriesRepository;
  final ProductRepository productRepository;
  final BookmarkRepository bookmarkRepository;
  final CartRepository cartRepository;
  final PagesRepository pagesRepository;
  final SessionRepository sessionRepository;

  final Widget child;

  const ServiceFactory(
    this.accountRepository,
    this.categoriesRepository,
    this.productRepository,
    this.bookmarkRepository,
    this.cartRepository,
    this.pagesRepository,
    this.sessionRepository, {
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthStateBloc>(
          lazy: false,
          create: (context) => AuthStateBloc(
            accountRepository,
          )..add(OnAuthStateEvent()),
        ),
        BlocProvider<SortReviewsBloc>(
          create: (context) => SortReviewsBloc(),
        ),
        BlocProvider<LoadSessionBloc>(
          create: (context) => LoadSessionBloc(
            sessionRepository,
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            accountRepository,
          ),
        ),
        BlocProvider<LogoutBloc>(
          create: (context) => LogoutBloc(
            accountRepository,
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
        BlocProvider<LoadProductByIdBloc>(
          create: (context) => LoadProductByIdBloc(
            productRepository,
          ),
        ),
        BlocProvider<LoadPageBloc>(
          create: (context) => LoadPageBloc(
            pagesRepository,
          ),
        ),
        BlocProvider<AddBookmarkBloc>(
          create: (context) => AddBookmarkBloc(
            bookmarkRepository,
          ),
        ),
        BlocProvider<LoadBookmarkBloc>(
          create: (context) => LoadBookmarkBloc(
            productRepository,
          ),
        ),
        BlocProvider<AddToCartBloc>(
          create: (context) => AddToCartBloc(
            cartRepository,
          ),
        ),
        BlocProvider<LoadCartBloc>(
          create: (context) => LoadCartBloc(
            cartRepository,
            productRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
