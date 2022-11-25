part of "sort_reviews_bloc.dart";

abstract class SortReviewsState extends Equatable {
  const SortReviewsState();

  @override
  List<Object> get props => [];
}

class SortReviewsInitialState extends SortReviewsState {
  final SortReviewTypeEnum sortReviewsType;

  const SortReviewsInitialState({
    this.sortReviewsType = SortReviewTypeEnum.rating,
  });

  @override
  List<Object> get props => [
        sortReviewsType,
      ];
}
