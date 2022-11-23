import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/components/custom_modal_bottom_sheet.dart";
import "package:shop/constants.dart";
import "package:shop/route/screen_export.dart";
import "package:shop/screens/auth/views/components/sign_up_verification_otp_form.dart";
import "package:shop/services/accounts/validate/validate_account_bloc.dart";
import "package:shop/services/session/load/load_session_bloc.dart";
import "package:shop/utils/notice.dart";
import "package:shop/utils/translate.dart";

class SignUpVerificationScreen extends StatefulWidget {
  const SignUpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SignUpVerificationScreen> createState() =>
      _SignUpVerificationScreenState();
}

class _SignUpVerificationScreenState extends State<SignUpVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<List<String>> _code =
      ValueNotifier<List<String>>(["", "", "", ""]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<LoadSessionBloc, LoadSessionState>(
        bloc: context.read<LoadSessionBloc>()..add(OnLoadSessionEvent()),
        builder: (context, state) {
          String email = "";

          if (state is LoadSessionSuccessState) {
            email = state.session.email;
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verification code",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  const Text("We have sent the code verification to "),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding,
                    ),
                    child: Row(
                      children: [
                        Text(
                          email,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                  SignUpVerificationOtpForm(
                    controller: _code,
                    formKey: _formKey,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  const Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Resend code after ",
                        children: [
                          TextSpan(
                            text: "1:36",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Resend"),
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      Expanded(
                        child: BlocListener<ValidateAccountBloc,
                            ValidateAccountState>(
                          listener: (context, state) async {
                            if (state is ValidateAccountFailureState) {
                              _code.value = ["", "", "", ""];

                              notice(
                                context,
                                t(context)!.signup_account_not_validated_label,
                              );

                              return;
                            }

                            if (state is ValidateAccountSuccessState) {
                              customModalBottomSheet(
                                context,
                                isDismissible: false,
                                child: SafeArea(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? "assets/Illustration/success.png"
                                              : "assets/Illustration/success_dark.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                        ),
                                        const Spacer(),
                                        Text(
                                          "Whoohooo!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        const SizedBox(
                                            height: defaultPadding / 2),
                                        const Text(
                                          "Your email has been verified succesfully.",
                                        ),
                                        const Spacer(),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              entryPointScreenRoute,
                                              ModalRoute.withName(
                                                signUpVerificationScreenRoute,
                                              ),
                                            );
                                          },
                                          child: const Text("Go to shopping"),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              if (_code.value.isEmpty) return;

                              context.read<ValidateAccountBloc>().add(
                                    OnValidateAccountEvent(
                                      _code.value.join(),
                                    ),
                                  );

                              _formKey.currentState?.reset();
                            },
                            child: const Text("Confirm"),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
