part of "sort_reviews_bloc.dart";

abstract class SortReviewsEvent extends Equatable {
  const SortReviewsEvent();

  @override
  List<Object> get props => [];
}

class OnSortReviewsEvent extends SortReviewsEvent {
  final SortReviewTypeEnum sortReviewsType;

  const OnSortReviewsEvent(
    this.sortReviewsType,
  );

  @override
  List<Object> get props => [
        sortReviewsType,
      ];
}
