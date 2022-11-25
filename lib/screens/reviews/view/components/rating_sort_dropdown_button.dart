import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/services/reviews/sort_reviews/sort_reviews_bloc.dart";

class RatingSortDropdownButton extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final SortReviewTypeEnum value;
  final ValueChanged<SortReviewTypeEnum?> onChanged;

  const RatingSortDropdownButton({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SortReviewTypeEnum>(
      value: value,
      icon: SvgPicture.asset(
        "assets/icons/miniDown.svg",
        color: Theme.of(context).iconTheme.color,
      ),
      style: Theme.of(context).textTheme.subtitle2,
      underline: const SizedBox(),
      onChanged: onChanged,
      items: items
          .map(
            (e) => DropdownMenuItem<SortReviewTypeEnum>(
              value: e["value"],
              child: Text(e["label"]),
            ),
          )
          .toList(),
    );
  }
}
