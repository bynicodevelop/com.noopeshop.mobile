import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:shop/components/product/product_card.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/route/route_constants.dart";
import "package:shop/screens/bookmark/component/bookmarks_skelton.dart";
import "package:shop/services/bookmark/load_bookmark/load_bookmark_bloc.dart";
import "package:shop/utils/assets_network.dart";
import "package:shop/utils/format/price.dart";
import "package:shop/utils/translate.dart";

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

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/Bookmark.svg",
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
                    t(context)!.bookmark_empty_title_label,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.3),
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            );
          }

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
