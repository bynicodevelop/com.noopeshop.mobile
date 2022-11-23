import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/models/account_model.dart";
import "package:shop/screens/auth/views/components/sign_up_form.dart";
import "package:shop/route/route_constants.dart";
import "package:shop/services/accounts/create/create_account_bloc.dart";
import "package:shop/utils/notice.dart";
import "package:shop/utils/translate.dart";

import "../../../constants.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _termsAndConditions = false;

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _emailController.text = "john@domain.tld";
      _passwordController.text = "password!";
      _termsAndConditions = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/signUp_dark.png",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t(context)!.signup_get_started_label,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  Text(
                    t(context)!.signup_complet_form_label,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  SignUpForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (value) => setState(
                          () => _termsAndConditions = !_termsAndConditions,
                        ),
                        value: _termsAndConditions,
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: t(context)!.signup_I_agree_label,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    Navigator.pushNamed(
                                      context,
                                      termsOfServicesScreenRoute,
                                    );
                                  },
                                text: t(context)!.signup_terms_label,
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: t(context)!.signup_conditions_label,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  BlocListener<CreateAccountBloc, CreateAccountState>(
                    listener: (context, state) async {
                      if (state is CreateAccountFailureState) {
                        String message = t(context)!.notice_unknown;

                        if (state.code == "user_already_exists") {
                          message = t(context)!.notice_user_already_exists;
                        }

                        notice(
                          context,
                          message,
                        );

                        return;
                      }

                      if (state is CreateAccountSuccessState) {
                        Navigator.pushNamed(
                          context,
                          signUpVerificationScreenRoute,
                        );
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!_termsAndConditions) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                t(context)!
                                    .signup_please_accept_conditions_label,
                              ),
                            ),
                          );

                          return;
                        }

                        if (!_formKey.currentState!.validate()) return;

                        context.read<CreateAccountBloc>().add(
                              OnCreateAccountEvent(
                                account: AccountModel(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              ),
                            );
                      },
                      child: Text(
                        t(context)!.signup_continue_label,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t(context)!.signup_have_account_label,
                      ),
                      TextButton(
                        onPressed: () async => Navigator.pushNamed(
                          context,
                          logInScreenRoute,
                        ),
                        child: Text(t(context)!.signup_login_label),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
