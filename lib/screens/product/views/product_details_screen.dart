import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:shop/components/cart_button.dart";
import "package:shop/components/custom_modal_bottom_sheet.dart";
import "package:shop/components/product/product_card.dart";
import "package:shop/constants.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/inputs/product_input.dart";
import "package:shop/screens/product/views/product_info_screen.dart";
import "package:shop/screens/product/views/product_returns_screen.dart";
import "package:shop/screens/product/views/shipping_methods_screen.dart";
import "package:shop/route/screen_export.dart";
import "package:shop/services/bookmark/add_bookmark/add_bookmark_bloc.dart";
import "package:shop/services/products/load_product_by_id/load_product_by_id_bloc.dart";
import "package:shop/utils/assets_network.dart";
import "package:shop/utils/format/price.dart";
import "package:shop/utils/helpers/rating_by_star.dart";
import "package:shop/utils/translate.dart";

import "components/notify_me_card.dart";
import "components/product_images.dart";
import "components/product_info.dart";
import "components/product_list_tile.dart";
import "../../../components/review_card.dart";
import "product_buy_now_screen.dart";

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity productEntity;

  const ProductDetailsScreen({
    Key? key,
    required this.productEntity,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadProductByIdBloc, LoadProductByIdState>(
      bloc: context.read<LoadProductByIdBloc>()
        ..add(OnLoadProductByIdEvent(
          widget.productEntity.id,
        )),
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: widget.productEntity.sellWithoutStock
              ? CartButton(
                  price: 140,
                  title: t(context)!.cart_button_buy_now_label,
                  subTitle: t(context)!.cart_button_unit_label,
                  press: () async {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const ProductBuyNowScreen(),
                    );
                  },
                )
              : NotifyMeCard(
                  isNotify: false,
                  onChanged: (value) {},
                ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  floating: true,
                  actions: [
                    BlocBuilder<AddBookmarkBloc, AddBookmarkState>(
                      builder: (context, state) {
                        bool isBookmarked = widget.productEntity.isBookmarked;

                        if (state is AddBookmarkSuccessState) {
                          isBookmarked = state.isBookmarked;
                        }

                        return IconButton(
                          onPressed: () => context
                              .read<AddBookmarkBloc>()
                              .add(OnAddBookmarkEvent(
                                ProductInput(
                                  id: widget.productEntity.id,
                                ),
                              )),
                          icon: SvgPicture.asset(
                            "assets/icons/Bookmark.svg",
                            color: isBookmarked
                                ? primaryColor
                                : Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ProductImages(
                  images: widget.productEntity.previews
                      .map(
                        (e) => networkImage(e),
                      )
                      .toList(),
                ),
                ProductInfo(
                  brand: widget.productEntity.brandName,
                  title: widget.productEntity.title,
                  isAvailable: widget.productEntity.sellWithoutStock,
                  description: widget.productEntity.productInfo,
                  rating: double.parse(
                      widget.productEntity.rating.toStringAsFixed(1)),
                  numOfReviews: widget.productEntity.nbReviews,
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Product.svg",
                  title: t(context)!.products_details_label,
                  press: () async {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: ProductInfoScreen(
                        productEntity: widget.productEntity,
                      ),
                    );
                  },
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Delivery.svg",
                  title: t(context)!.products_shipping_info_label,
                  press: () async {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const ShippingMethodsScreen(),
                    );
                  },
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Return.svg",
                  title: t(context)!.products_return_label,
                  isShowBottomBorder: true,
                  press: () async {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const ProductReturnsScreen(),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      defaultPadding,
                    ),
                    child: ReviewCard(
                      rating: double.parse(
                          widget.productEntity.rating.toStringAsFixed(1)),
                      numOfReviews: widget.productEntity.nbReviews,
                      numOfFiveStar:
                          ratingByStar(widget.productEntity.reviews, 5),
                      numOfFourStar:
                          ratingByStar(widget.productEntity.reviews, 4),
                      numOfThreeStar:
                          ratingByStar(widget.productEntity.reviews, 3),
                      numOfTwoStar:
                          ratingByStar(widget.productEntity.reviews, 2),
                      numOfOneStar:
                          ratingByStar(widget.productEntity.reviews, 1),
                    ),
                  ),
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Chat.svg",
                  title: t(context)!.products_reviews_label,
                  isShowBottomBorder: true,
                  press: () async => Navigator.pushNamed(
                    context,
                    productReviewsScreenRoute,
                    arguments: widget.productEntity,
                  ),
                ),
                if (state is LoadProductByIdLoadedState &&
                    state.productEntity.relatedProducts.isNotEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.all(defaultPadding),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        t(context)!.related_may_like_label,
                        style: Theme.of(context).textTheme.subtitle2!,
                      ),
                    ),
                  ),
                if (state is LoadProductByIdLoadedState &&
                    state.productEntity.relatedProducts.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.productEntity.relatedProducts.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              left: defaultPadding,
                              right: index == 4 ? defaultPadding : 0),
                          child: ProductCard(
                            image: networkImage(
                              state.productEntity.relatedProducts[index]
                                  .thumbnail,
                            ),
                            title: state
                                .productEntity.relatedProducts[index].title,
                            brandName: state
                                .productEntity.relatedProducts[index].brandName,
                            price: priceFormat(
                              state.productEntity.relatedProducts[index].price,
                            ),
                            priceAfetDiscount: state
                                        .productEntity
                                        .relatedProducts[index]
                                        .priceAfterDiscount !=
                                    null
                                ? priceFormat(state.productEntity
                                    .relatedProducts[index].priceAfterDiscount!)
                                : null,
                            dicountpercent: state.productEntity
                                .relatedProducts[index].dicountpercent,
                            press: () async {
                              await Navigator.pushNamed(
                                context,
                                productDetailsScreenRoute,
                                arguments:
                                    state.productEntity.relatedProducts[index],
                              );

                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: defaultPadding),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
