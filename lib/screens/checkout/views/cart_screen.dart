import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:shop/components/product/secondary_product_card.dart";
import "package:shop/inputs/cart_input.dart";
import "package:shop/models/product_model.dart";
import "package:shop/route/screen_export.dart";
import "package:shop/screens/order/views/components/order_summary_card.dart";
import "package:shop/services/cart/load_cart/load_cart_bloc.dart";
import "package:shop/utils/assets_network.dart";
import "package:shop/utils/helpers/total.dart";
import "package:shop/utils/translate.dart";

import "../../../constants.dart";
import "components/coupon_code.dart";

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadCartBloc, LoadCartState>(
      bloc: context.read<LoadCartBloc>()..add(OnLoadCartEvent()),
      builder: (context, state) {
        final List<CartInput> cart = (state as LoadCartInitialState).cart;

        if (cart.isEmpty) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Bag.svg",
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.3),
                      width: 40.0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      t(context)!.cart_empty_title_label,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(.3),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(
                          context,
                          entryPointScreenRoute,
                        );
                      },
                      child: Text(
                        t(context)!.add_to_cart_continue_shopping_label,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    "Review your order",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                // While loading use 👇
                // const ReviewYourItemsSkelton(),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: defaultPadding,
                        ),
                        child: SecondaryProductCard(
                          image: networkImage(cart[index].variant.thumbnail),
                          brandName: demoPopularProducts[index].brandName,
                          title: cart[index].variant.title,
                          price:
                              cart[index].variant.price * cart[index].quantity,
                          priceAfetDiscount:
                              cart[index].variant.priceAfterDiscount != null
                                  ? cart[index].variant.priceAfterDiscount! *
                                      cart[index].quantity
                                  : null,
                          style: ElevatedButton.styleFrom(
                            maximumSize: const Size(
                              double.infinity,
                              80,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      childCount: cart.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CouponCode(),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding * 1.5,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: OrderSummaryCard(
                      subTotal: total(cart),
                      // discount: 10,
                      totalWithVat: total(cart),
                      vat: cart
                          .map((e) =>
                              e.variant.priceAfterDiscountVat ??
                              e.variant.priceVat)
                          .toList()
                          .reduce(
                            (value, element) => value + element,
                          ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(
                          context,
                          paymentMethodScreenRoute,
                        );
                      },
                      child: const Text("Continue"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
