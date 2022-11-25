import "package:shop/entities/review_entity.dart";

double averageRating(List<ReviewEntity> reviews) {
  if (reviews.isEmpty) {
    return 0;
  }

  double total = 0;

  for (var review in reviews) {
    total += review.rating;
  }

  return total / reviews.length;
}
