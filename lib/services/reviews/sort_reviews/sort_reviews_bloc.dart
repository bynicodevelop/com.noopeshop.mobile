import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "sort_reviews_event.dart";
part "sort_reviews_state.dart";

enum SortReviewTypeEnum {
  rating,
  date,
}

class SortReviewsBloc extends Bloc<SortReviewsEvent, SortReviewsState> {
  SortReviewsBloc() : super(const SortReviewsInitialState()) {
    on<OnSortReviewsEvent>((event, emit) {
      emit(SortReviewsInitialState(
        sortReviewsType: event.sortReviewsType,
      ));
    });
  }
}
