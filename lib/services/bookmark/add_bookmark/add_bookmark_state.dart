part of "add_bookmark_bloc.dart";

abstract class AddBookmarkState extends Equatable {
  const AddBookmarkState();

  @override
  List<Object> get props => [];
}

class AddBookmarkInitialState extends AddBookmarkState {}

class AddBookmarkLoadingState extends AddBookmarkState {}

class AddBookmarkSuccessState extends AddBookmarkState {
  final bool isBookmarked;

  const AddBookmarkSuccessState({
    this.isBookmarked = true,
  });

  @override
  List<Object> get props => [
        isBookmarked,
      ];
}

class AddBookmarkFailureState extends AddBookmarkState {
  final String code;

  const AddBookmarkFailureState(
    this.code,
  );

  @override
  List<Object> get props => [
        code,
      ];
}
