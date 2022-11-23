import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/repositories/session_repository.dart";
import "package:shop/services/accounts/create/create_account_bloc.dart";
import "package:shop/services/accounts/validate/validate_account_bloc.dart";
import "package:shop/services/session/load/load_session_bloc.dart";

class ServiceFactory extends StatelessWidget {
  final AccountRepository accountRepository;
  final SessionRepository sessionRepository;

  final Widget child;

  const ServiceFactory(
    this.accountRepository,
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
      ],
      child: child,
    );
  }
}
