import "package:flutter/material.dart";
import "package:shop/utils/translate.dart";

import "../../../../constants.dart";

class ProductAvailabilityTag extends StatelessWidget {
  const ProductAvailabilityTag({
    Key? key,
    required this.isAvailable,
  }) : super(key: key);

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: isAvailable ? successColor : errorColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultBorderRadious / 2),
        ),
      ),
      child: Text(
        isAvailable
            ? t(context)!.products_available_stock_label
            : t(context)!.products_unavailable_stock_label,
        style: Theme.of(context)
            .textTheme
            .overline!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
