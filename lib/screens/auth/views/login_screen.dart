import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/material.dart";
import "package:shop/constants.dart";
import "package:shop/route/route_constants.dart";
import "package:shop/services/accounts/login/login_bloc.dart";
import "package:shop/utils/notice.dart";

import "components/login_form.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _emailController.text = "john@domain.tld";
      _passwordController.text = "password!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login_dark.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(
                defaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back!",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Log in with your data that you intered during your registration.",
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  LogInForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  Align(
                    child: TextButton(
                      child: const Text("Forgot password"),
                      onPressed: () async {
                        Navigator.pushNamed(
                            context, passwordRecoveryScreenRoute);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) async {
                      if (state is LoginFailureState) {
                        notice(
                          context,
                          state.code,
                        );
                      }

                      if (state is LoginSuccessState) {
                        Navigator.pushNamed(
                          context,
                          entryPointScreenRoute,
                        );
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                                OnLoginEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context,
                          //     entryPointScreenRoute,
                          //     ModalRoute.withName(logInScreenRoute));
                        }
                      },
                      child: const Text("Log in"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, signUpScreenRoute);
                        },
                        child: const Text("Sign up"),
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
