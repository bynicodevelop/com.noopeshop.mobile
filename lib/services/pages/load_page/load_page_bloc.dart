import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/entities/page_entity.dart";
import "package:shop/exceptions/page_exception.dart";
import "package:shop/inputs/page_input.dart";
import "package:shop/repositories/pages_repository.dart";

part "load_page_event.dart";
part "load_page_state.dart";

class LoadPageBloc extends Bloc<LoadPageEvent, LoadPageState> {
  final PagesRepository pagesRepository;

  LoadPageBloc(
    this.pagesRepository,
  ) : super(LoadPageInitialState()) {
    on<OnLoadPageEvent>((event, emit) async {
      emit(LoadPageLoadingState());

      try {
        final PageEntity pageEntity = await pagesRepository.getPageBySlug(
          event.pageInput,
        );

        emit(LoadPageLoadedState(
          pageEntity,
        ));
      } on PageException catch (e) {
        emit(LoadPageFailureState(
          e.code,
        ));
      }
    });
  }
}
