import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/services/accounts/create/create_account_bloc.dart";

class ServiceFactory extends StatelessWidget {
  final AccountRepository accountRepository;

  final Widget child;

  const ServiceFactory(
    this.accountRepository, {
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateAccountBloc>(
          create: (context) => CreateAccountBloc(
            accountRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
