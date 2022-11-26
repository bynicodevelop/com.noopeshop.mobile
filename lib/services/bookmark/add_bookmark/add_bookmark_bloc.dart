import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/inputs/product_input.dart";
import "package:shop/repositories/bookmark_repository.dart";

part "add_bookmark_event.dart";
part "add_bookmark_state.dart";

class AddBookmarkBloc extends Bloc<AddBookmarkEvent, AddBookmarkState> {
  final BookmarkRepository bookmarkRepository;

  AddBookmarkBloc(
    this.bookmarkRepository,
  ) : super(AddBookmarkInitialState()) {
    on<OnAddBookmarkEvent>((event, emit) async {
      emit(AddBookmarkLoadingState());

      try {
        final bool isBookmarked = await bookmarkRepository.toggleBookmark(
          event.productInput,
        );

        emit(AddBookmarkSuccessState(
          isBookmarked: isBookmarked,
        ));
      } catch (e) {
        emit(AddBookmarkFailureState(
          e.toString(),
        ));
      }
    });
  }
}
