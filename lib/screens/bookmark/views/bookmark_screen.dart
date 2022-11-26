import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/components/product/product_card.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/route/route_constants.dart";
import "package:shop/screens/bookmark/component/bookmarks_skelton.dart";
import "package:shop/services/bookmark/load_bookmark/load_bookmark_bloc.dart";
import "package:shop/utils/assets_network.dart";
import "package:shop/utils/format/price.dart";

import "../../../constants.dart";

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoadBookmarkBloc, LoadBookmarkState>(
        bloc: context.read<LoadBookmarkBloc>()..add(OnLoadBookmarkEvent()),
        builder: (context, state) {
          final List<ProductEntity> products =
              (state as LoadBookmarkInitialState).products;

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
                          await Navigator.pushNamed(
                            context,
                            productDetailsScreenRoute,
                            arguments: products[index],
                          );

                          setState(() {});
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
