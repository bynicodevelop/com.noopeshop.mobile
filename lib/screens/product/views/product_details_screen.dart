import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:shop/components/cart_button.dart";
import "package:shop/components/custom_modal_bottom_sheet.dart";
import "package:shop/components/product/product_card.dart";
import "package:shop/constants.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/screens/product/views/product_info_screen.dart";
import "package:shop/screens/product/views/product_returns_screen.dart";
import "package:shop/screens/product/views/shipping_methods_screen.dart";
import "package:shop/route/screen_export.dart";
import "package:shop/utils/assets_network.dart";
import "package:shop/utils/helpers/rating_by_star.dart";
import "package:shop/utils/translate.dart";

import "components/notify_me_card.dart";
import "components/product_images.dart";
import "components/product_info.dart";
import "components/product_list_tile.dart";
import "../../../components/review_card.dart";
import "product_buy_now_screen.dart";

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductDetailsScreen({
    Key? key,
    required this.productEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: productEntity.sellWithoutStock
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
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              ],
            ),
            ProductImages(
              images: productEntity.previews
                  .map(
                    (e) => networkImage(e),
                  )
                  .toList(),
            ),
            ProductInfo(
              brand: productEntity.brandName,
              title: productEntity.title,
              isAvailable: productEntity.sellWithoutStock,
              description: productEntity.productInfo,
              rating: double.parse(productEntity.rating.toStringAsFixed(1)),
              numOfReviews: productEntity.nbReviews,
            ),
            ProductListTile(
              svgSrc: "assets/icons/Product.svg",
              title: t(context)!.products_details_label,
              press: () async {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: ProductInfoScreen(
                    productEntity: productEntity,
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
                  rating: double.parse(productEntity.rating.toStringAsFixed(1)),
                  numOfReviews: productEntity.nbReviews,
                  numOfFiveStar: ratingByStar(productEntity.reviews, 5),
                  numOfFourStar: ratingByStar(productEntity.reviews, 4),
                  numOfThreeStar: ratingByStar(productEntity.reviews, 3),
                  numOfTwoStar: ratingByStar(productEntity.reviews, 2),
                  numOfOneStar: ratingByStar(productEntity.reviews, 1),
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
                arguments: productEntity,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "You may also like",
                  style: Theme.of(context).textTheme.subtitle2!,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == 4 ? defaultPadding : 0),
                    child: ProductCard(
                      image: productDemoImg2,
                      title: "Sleeveless Tiered Dobby Swing Dress",
                      brandName: "LIPSY LONDON",
                      price: 24.65,
                      priceAfetDiscount: index.isEven ? 20.99 : null,
                      dicountpercent: index.isEven ? 25 : null,
                      press: () {},
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
  }
}
