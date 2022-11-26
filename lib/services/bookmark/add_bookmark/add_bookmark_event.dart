part of "add_bookmark_bloc.dart";

abstract class AddBookmarkEvent extends Equatable {
  const AddBookmarkEvent();

  @override
  List<Object> get props => [];
}

class OnAddBookmarkEvent extends AddBookmarkEvent {
  final ProductInput productInput;

  const OnAddBookmarkEvent(
    this.productInput,
  );

  @override
  List<Object> get props => [
        productInput,
      ];
}
