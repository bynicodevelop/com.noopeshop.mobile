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
                    "Let’s get started!",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  const Text(
                    "Please enter your valid data in order to create an account.",
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
                            text: "I agree with the",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    Navigator.pushNamed(
                                      context,
                                      termsOfServicesScreenRoute,
                                    );
                                  },
                                text: " Terms of service ",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(
                                text: "& privacy policy.",
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  BlocListener<CreateAccountBloc, CreateAccountState>(
                    listener: (context, state) {
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

                      if (state is CreateAccountSuccessState) {}
                    },
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!_termsAndConditions) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Please accept the terms and conditions."),
                            ),
                          );
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
                        // Navigator.pushNamed(
                        //   context,
                        //   profileSetupScreenRoute,
                        // );
                      },
                      child: const Text("Continue"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have an account?"),
                      TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, logInScreenRoute);
                        },
                        child: const Text("Log in"),
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
