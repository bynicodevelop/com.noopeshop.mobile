import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/services/reviews/sort_reviews/sort_reviews_bloc.dart";
import "package:shop/utils/translate.dart";

import "../../../../constants.dart";
import "rating_sort_dropdown_button.dart";

class SortUserReview extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          Expanded(
            child: Text(
              t(context)!.review_user_reviews_label,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SvgPicture.asset(
            "assets/icons/Sort.svg",
            color: Theme.of(context).iconTheme.color,
          ),
          const SizedBox(
            width: defaultPadding / 2,
          ),
          BlocBuilder<SortReviewsBloc, SortReviewsState>(
            builder: (context, state) {
              return RatingSortDropdownButton(
                items: [
                  {
                    "value": SortReviewTypeEnum.rating,
                    "label": t(context)!.review_most_useful_label,
                  },
                  {
                    "value": SortReviewTypeEnum.date,
                    "label": t(context)!.review_recent_label,
                  }
                ],
                value: (state as SortReviewsInitialState).sortReviewsType,
                onChanged: (value) {
                  if (value != null) {
                    context.read<SortReviewsBloc>().add(
                          OnSortReviewsEvent(value),
                        );
                  }
                  // Set the dropdown value
                },
              );
            },
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
