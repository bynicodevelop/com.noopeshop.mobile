import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/constants.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/utils/assets_network.dart";
import "package:shop/utils/translate.dart";

import "components/review_form.dart";
import "components/review_product_card.dart";

class AddReviewScreen extends StatefulWidget {
  final ProductEntity productEntity;

  const AddReviewScreen({
    Key? key,
    required this.productEntity,
  }) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t(context)!.review_add_label),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            ReviewProductInfoCard(
              image: networkImage(widget.productEntity.thumbnail),
              title: widget.productEntity.title,
              brand: widget.productEntity.brandName,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            const Divider(),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Text(t(context)!.review_vode_product_label),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            RatingBar.builder(
              initialRating: _rating,
              itemSize: 28,
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
              onRatingUpdate: (value) => setState(() => _rating = value),
              itemBuilder: (context, index) =>
                  SvgPicture.asset("assets/icons/Star_filled.svg"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: defaultPadding,
              ),
              child: Divider(),
            ),
            ReviewForm(
              onSubmit: (review, recommandation) {
                print(review);
                print(recommandation);
                print(_rating);

                // Navigator.popAndPushNamed(
                //   context,
                //   productReviewsScreenRoute,
                //   arguments: widget.productEntity,
                // );
              },
            )
          ],
        ),
      ),
    );
  }
}
