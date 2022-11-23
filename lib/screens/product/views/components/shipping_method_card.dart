import "package:flutter/material.dart";

import "../../../../constants.dart";

class ShippingMethodCard extends StatelessWidget {
  const ShippingMethodCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String title, subtitle;
  final double price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      shape: RoundedRectangleBorder(
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultBorderRadious)),
          side: BorderSide(
              width: 1.5,
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.1))),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: defaultPadding),
          Text(
            "\$" + price.toStringAsFixed(2),
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        child: Text(subtitle),
      ),
    );
  }
}
