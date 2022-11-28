import "package:flutter/material.dart";
import "package:shop/constants.dart";
import "package:shop/route/screen_export.dart";
import "package:shop/utils/translate.dart";

class AddedToCartMessageScreen extends StatelessWidget {
  const AddedToCartMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                Theme.of(context).brightness == Brightness.light
                    ? "assets/Illustration/success.png"
                    : "assets/Illustration/success_dark.png",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const Spacer(flex: 2),
              Text(
                t(context)!.add_to_cart_added_title_label,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: defaultPadding / 2),
              Text(
                t(context)!.add_to_cart_added_subtitle_label,
                textAlign: TextAlign.center,
              ),
              const Spacer(
                flex: 2,
              ),
              OutlinedButton(
                onPressed: () async => Navigator.pushNamed(
                  context,
                  entryPointScreenRoute,
                ),
                child: Text(t(context)!.add_to_cart_continue_shopping_label),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              // TODO: cette redirection nécessite de naviguer vers les pages view
              ElevatedButton(
                onPressed: () {},
                child: Text(t(context)!.add_to_cart_checkout_label),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
