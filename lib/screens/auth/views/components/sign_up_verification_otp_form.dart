import "package:flutter/material.dart";
import "package:flutter/services.dart";

class SignUpVerificationOtpForm extends StatelessWidget {
  final ValueNotifier<List<String>> controller;
  final GlobalKey<FormState> formKey;

  const SignUpVerificationOtpForm({
    Key? key,
    required this.controller,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 64,
            width: 68,
            child: TextFormField(
              onSaved: (pin1) {},
              autofocus: true,
              onChanged: (value) {
                if (value.length == 1) {
                  controller.value[0] = value;

                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
              maxLength: 1,
              decoration: const InputDecoration(counterText: ""),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          SizedBox(
            height: 64,
            width: 68,
            child: TextFormField(
              onSaved: (pin2) {},
              onChanged: (value) {
                if (value.length == 1) {
                  controller.value[1] = value;

                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
              maxLength: 1,
              decoration: const InputDecoration(counterText: ""),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          SizedBox(
            height: 64,
            width: 68,
            child: TextFormField(
              onSaved: (pin3) {},
              onChanged: (value) {
                if (value.length == 1) {
                  controller.value[2] = value;

                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
              maxLength: 1,
              decoration: const InputDecoration(counterText: ""),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          SizedBox(
            height: 64,
            width: 68,
            child: TextFormField(
              onSaved: (pin4) {},
              onChanged: (value) {
                if (value.length == 1) {
                  controller.value[3] = value;

                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
              maxLength: 1,
              decoration: const InputDecoration(counterText: ""),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ],
      ),
    );
  }
}
