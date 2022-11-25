import "package:shop/entities/review_entity.dart";

int ratingByStar(List<ReviewEntity> reviews, int star) {
  int count = 0;

  for (var review in reviews) {
    if (review.rating >= star && review.rating < star + 1) {
      count++;
    }
  }

  return count;
}
