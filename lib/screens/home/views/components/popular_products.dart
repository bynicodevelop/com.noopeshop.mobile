import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/components/product/product_card.dart";
import "package:shop/components/skleton/product/products_skelton.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/models/product_model.dart";
import "package:shop/route/screen_export.dart";
import "package:shop/services/products/load_latest_products/load_latest_products_bloc.dart";
import "package:shop/utils/assets_network.dart";
import "package:shop/utils/format/price.dart";
import "package:shop/utils/translate.dart";

import "../../../../constants.dart";

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            t(context)!.products_latest_label,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        BlocBuilder<LoadLatestProductsBloc, LoadLatestProductsState>(
          bloc: context.read<LoadLatestProductsBloc>()
            ..add(OnLoadLatestProductsEvent()),
          builder: (context, state) {
            final List<ProductEntity> products =
                (state as LoadLatestProductsInitialState).products;

            if (state.loading) {
              return const ProductsSkelton();
            }

            return SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: defaultPadding,
                    right: index == demoPopularProducts.length - 1
                        ? defaultPadding
                        : 0,
                  ),
                  child: ProductCard(
                    image: networkImage(products[index].thumbnail),
                    brandName: products[index].brandName,
                    title: products[index].title,
                    price: priceFormat(products[index].price),
                    priceAfetDiscount:
                        products[index].priceAfterDiscount != null
                            ? priceFormat(products[index].priceAfterDiscount!)
                            : null,
                    dicountpercent: products[index].dicountpercent,
                    press: () async => Navigator.pushNamed(
                      context,
                      productDetailsScreenRoute,
                      arguments: products[index],
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
