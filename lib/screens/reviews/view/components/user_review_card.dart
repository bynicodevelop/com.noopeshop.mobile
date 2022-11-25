import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/components/network_image_with_loader.dart";

import "../../../../constants.dart";

class UserReviewCard extends StatelessWidget {
  final String name;
  final String review;
  final String time;
  final String? userImage;
  final double rating;

  const UserReviewCard({
    Key? key,
    required this.name,
    required this.review,
    required this.time,
    this.userImage,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.05),
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRadious)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.1),
                child: userImage == null
                    ? SvgPicture.asset(
                        "assets/icons/Profile.svg",
                        height: 16,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.3),
                      )
                    : NetworkImageWithLoader(userImage!),
              ),
              const SizedBox(
                width: defaultPadding / 2,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(
                width: defaultPadding / 4,
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.caption,
              ),
              const Spacer(),
              RatingBar.builder(
                initialRating: rating,
                itemSize: 16,
                itemPadding: const EdgeInsets.only(
                  right: defaultPadding / 4,
                ),
                unratedColor: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.08),
                glow: false,
                allowHalfRating: true,
                ignoreGestures: true,
                onRatingUpdate: (value) {},
                itemBuilder: (context, index) =>
                    SvgPicture.asset("assets/icons/Star_filled.svg"),
              ),
            ],
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Text(
            review,
          )
        ],
      ),
    );
  }
}
