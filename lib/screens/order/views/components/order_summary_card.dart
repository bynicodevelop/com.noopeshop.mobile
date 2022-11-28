import "package:flutter/material.dart";
import "package:shop/utils/translate.dart";

import "../../../../constants.dart";

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    Key? key,
    required this.subTotal,
    this.shippingFee = 0,
    required this.totalWithVat,
    required this.vat,
    this.discount,
  }) : super(key: key);
  final double subTotal, shippingFee, totalWithVat, vat;
  final double? discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRadious)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t(context)!.cart_review_order_label,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding / 2,
            ),
            child: OrderSummaryText(
              leadingText: t(context)!.cart_review_subtotal_label,
              trilingText: "\$${subTotal.toStringAsFixed(2)}",
            ),
          ),
          OrderSummaryText(
            leadingText: t(context)!.cart_review_shipping_fee_label,
            trilingText: shippingFee == 0 ? "Free" : "\$$shippingFee",
            trilingTextColor: shippingFee == 0 ? successColor : null,
          ),
          if (discount != null)
            const SizedBox(
              height: defaultPadding / 2,
            ),
          if (discount != null)
            OrderSummaryText(
              leadingText: t(context)!.cart_review_discount_label,
              trilingText: "\$$discount",
            ),
          const Divider(
            height: defaultPadding * 2,
          ),
          OrderSummaryText(
            leadingText: t(context)!.cart_review_total_with_vat_label,
            trilingText: "\$${totalWithVat.toStringAsFixed(2)}",
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          OrderSummaryText(
            leadingText: t(context)!.cart_review_estimated_vat_label,
            trilingText: "\$$vat",
          ),
        ],
      ),
    );
  }
}

class OrderSummaryText extends StatelessWidget {
  const OrderSummaryText({
    Key? key,
    required this.leadingText,
    required this.trilingText,
    this.trilingTextColor,
  }) : super(key: key);

  final String leadingText, trilingText;
  final Color? trilingTextColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(leadingText),
        const Spacer(),
        Text(
          trilingText,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: trilingTextColor),
        ),
      ],
    );
  }
}
