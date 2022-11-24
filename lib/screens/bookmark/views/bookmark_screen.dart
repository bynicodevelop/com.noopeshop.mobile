import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/components/product/product_card.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/route/route_constants.dart";
import "package:shop/screens/bookmark/component/bookmarks_skelton.dart";
import "package:shop/services/products/load_latest_products/load_latest_products_bloc.dart";
import "package:shop/utils/assets_network.dart";
import "package:shop/utils/format/price.dart";

import "../../../constants.dart";

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoadLatestProductsBloc, LoadLatestProductsState>(
        bloc: context.read<LoadLatestProductsBloc>()
          ..add(OnLoadLatestProductsEvent()),
        builder: (context, state) {
          final List<ProductEntity> products =
              (state as LoadLatestProductsInitialState).products;

          return CustomScrollView(
            slivers: [
              // While loading use 👇
              if (state.loading) const BookMarksSlelton(),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: defaultPadding,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: defaultPadding,
                    crossAxisSpacing: defaultPadding,
                    childAspectRatio: 0.70,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ProductCard(
                        image: networkImage(products[index].thumbnail),
                        brandName: products[index].brandName,
                        title: products[index].title,
                        price: priceFormat(products[index].price),
                        priceAfetDiscount: products[index].priceAfterDiscount !=
                                null
                            ? priceFormat(products[index].priceAfterDiscount!)
                            : null,
                        dicountpercent: products[index].dicountpercent,
                        press: () async {
                          Navigator.pushNamed(
                            context,
                            productDetailsScreenRoute,
                          );
                        },
                      );
                    },
                    childCount: products.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
