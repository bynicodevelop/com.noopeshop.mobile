// ignore_for_file: discarded_futures

import "package:bloc_test/bloc_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:shop/exceptions/account_exception.dart";
import "package:shop/repositories/account_repository.dart";
import "package:shop/services/accounts/validate/validate_account_bloc.dart";

@GenerateNiceMocks([MockSpec<AccountRepository>()])
import "validate_account_bloc_test.mocks.dart";

void main() {
  blocTest<ValidateAccountBloc, ValidateAccountState>(
    "Doit permettre la validation d'un compte avec succes",
    build: () {
      final AccountRepository accountRepository = MockAccountRepository();

      when(
        accountRepository.validateEmail("1234"),
      ).thenAnswer(
        (_) async => Future.value(),
      );

      return ValidateAccountBloc(
        accountRepository,
      );
    },
    act: (bloc) => bloc.add(
      const OnValidateAccountEvent(
        "1234",
      ),
    ),
    expect: () => [
      ValidateAccountLoadingState(),
      ValidateAccountSuccessState(),
    ],
  );

  blocTest<ValidateAccountBloc, ValidateAccountState>(
    "Doit permettre la validation d'un compte avec une erreur",
    build: () {
      final AccountRepository accountRepository = MockAccountRepository();

      when(
        accountRepository.validateEmail("1234"),
      ).thenThrow(
        AccountException(
          "Erreur",
          "code",
        ),
      );

      return ValidateAccountBloc(
        accountRepository,
      );
    },
    act: (bloc) => bloc.add(
      const OnValidateAccountEvent(
        "1234",
      ),
    ),
    expect: () => [
      ValidateAccountLoadingState(),
      const ValidateAccountFailureState(
        "code",
      ),
    ],
  );
}
