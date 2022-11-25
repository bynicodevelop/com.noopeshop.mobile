import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/components/review_card.dart";
import "package:shop/constants.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/screens/product/views/components/product_list_tile.dart";
import "package:shop/route/screen_export.dart";
import "package:shop/services/reviews/sort_reviews/sort_reviews_bloc.dart";
import "package:shop/utils/helpers/rating_by_star.dart";
import "package:shop/utils/translate.dart";
import "package:timeago/timeago.dart" as timeago;

import "components/sort_user_review.dart";
import "components/user_review_card.dart";

class ProductReviewsScreen extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductReviewsScreen({
    Key? key,
    required this.productEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(t(context)!.products_reviews_label),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: ReviewCard(
                rating: double.parse(productEntity.rating.toStringAsFixed(1)),
                numOfReviews: productEntity.reviews.length,
                numOfFiveStar: ratingByStar(productEntity.reviews, 5),
                numOfFourStar: ratingByStar(productEntity.reviews, 4),
                numOfThreeStar: ratingByStar(productEntity.reviews, 3),
                numOfTwoStar: ratingByStar(productEntity.reviews, 2),
                numOfOneStar: ratingByStar(productEntity.reviews, 1),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding,
            ),
            sliver: ProductListTile(
              title: t(context)!.review_add_review_label,
              svgSrc: "assets/icons/Chat-add.svg",
              isShowBottomBorder: true,
              press: () async {
                Navigator.pushNamed(context, addReviewsScreenRoute);
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            sliver: SliverPersistentHeader(
              delegate: SortUserReview(),
              pinned: true,
            ),
          ),
          BlocBuilder<SortReviewsBloc, SortReviewsState>(
            builder: (context, state) {
              final SortReviewTypeEnum order =
                  (state as SortReviewsInitialState).sortReviewsType;

              if (order == SortReviewTypeEnum.rating) {
                productEntity.reviews
                    .sort((a, b) => b.rating.compareTo(a.rating));
              } else if (order == SortReviewTypeEnum.date) {
                productEntity.reviews
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(
                        top: defaultPadding,
                      ),
                      child: UserReviewCard(
                        rating: productEntity.reviews[index].rating,
                        name: productEntity.reviews[index].fullName,
                        userImage: index.isEven
                            ? null
                            : "https://i.imgur.com/4h34UKX.png",
                        time: timeago.format(
                          productEntity.reviews[index].createdAt,
                        ),
                        review: productEntity.reviews[index].content,
                      ),
                    ),
                    childCount: productEntity.reviews.length,
                  ),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: defaultPadding * 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
