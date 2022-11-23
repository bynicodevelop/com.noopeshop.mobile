import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/constants.dart";
import "package:shop/route/route_constants.dart";

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Text(
                "Password recovery",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: defaultPadding / 2),
              const Text("Enter your E-mail address to recover your password"),
              const SizedBox(height: defaultPadding * 2),
              Form(
                child: TextFormField(
                  autofocus: true,
                  onSaved: (emal) {
                    // Email
                  },
                  validator: emaildValidator,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email address",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 0.75),
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
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, verificationMethodScreenRoute);
                },
                child: const Text("Next"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
