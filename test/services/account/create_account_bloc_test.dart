// ignore_for_file: discarded_futures

import "package:bloc_test/bloc_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:shop/entities/account_entity.dart";
import "package:shop/exceptions/account_exception.dart";
import "package:shop/models/account_model.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/services/accounts/create/create_account_bloc.dart";

@GenerateNiceMocks([MockSpec<AccountRepository>()])
import "create_account_bloc_test.mocks.dart";

void main() {
  blocTest<CreateAccountBloc, CreateAccountState>(
    "Doit permettre la création d'un compte avec succes",
    build: () {
      final AccountRepository accountRepository = MockAccountRepository();

      when(
        accountRepository.create(const AccountModel(
          email: "john@domain.tld",
          password: "password",
        )),
      ).thenAnswer(
        (_) async => const AccountEntity(
          id: "1",
          email: "john@domain.tld",
        ),
      );

      return CreateAccountBloc(
        accountRepository,
      );
    },
    act: (bloc) => bloc.add(const OnCreateAccountEvent(
      account: AccountModel(
        email: "john@domain.tld",
        password: "password",
      ),
    )),
    expect: () => [
      CreateAccountLoadingState(),
      const CreateAccountSuccessState(
        account: AccountEntity(
          id: "1",
          email: "john@domain.tld",
        ),
      ),
    ],
  );

  blocTest<CreateAccountBloc, CreateAccountState>(
    "Doit gérer la création d'un compte avec erreur",
    build: () {
      final AccountRepository accountRepository = MockAccountRepository();

      when(
        accountRepository.create(const AccountModel(
          email: "john@domain.tld",
          password: "password",
        )),
      ).thenThrow(
        AccountException(
          "Erreur",
          "unexpected_error",
        ),
      );

      return CreateAccountBloc(
        accountRepository,
      );
    },
    act: (bloc) => bloc.add(const OnCreateAccountEvent(
      account: AccountModel(
        email: "john@domain.tld",
        password: "password",
      ),
    )),
    expect: () => [
      CreateAccountLoadingState(),
      const CreateAccountFailureState(
        code: "unexpected_error",
      ),
    ],
  );
}
