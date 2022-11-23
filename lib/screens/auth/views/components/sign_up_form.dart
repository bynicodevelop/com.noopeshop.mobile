import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/utils/translate.dart";

import "../../../../constants.dart";

class SignUpForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignUpForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _errors = {
      "email_required": t(context)!.signup_email_required_label,
      "email_invalid": t(context)!.signup_email_invalid_label,
      "password_required": t(context)!.signup_password_required_label,
      "password_min_length": t(context)!.signup_password_min_length_label,
      "password_min_special_character":
          t(context)!.signup_password_min_special_character_label,
    };

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            validator: (value) {
              final List<String?> errors =
                  emaildValidator.validators.map((validator) {
                if (!validator.isValid(value)) {
                  return validator.errorText;
                }
              }).toList();

              final String? key = errors.firstWhere(
                (element) => element != null,
                orElse: () => null,
              );

              if (key != null) {
                return _errors[key];
              }

              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: t(context)!.signup_email_label,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding * 0.75,
                ),
                child: SvgPicture.asset(
                  "assets/icons/Message.svg",
                  height: 24,
                  width: 24,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.3),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              List<String?> errors =
                  passwordValidator.validators.map((validator) {
                if (!validator.isValid(value)) {
                  return validator.errorText;
                }
              }).toList();

              final String? key = errors.firstWhere(
                (element) => element != null,
                orElse: () => null,
              );

              if (key != null) {
                return _errors[key];
              }

              return null;
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: t(context)!.signup_password_label,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding * 0.75,
                ),
                child: SvgPicture.asset(
                  "assets/icons/Lock.svg",
                  height: 24,
                  width: 24,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
