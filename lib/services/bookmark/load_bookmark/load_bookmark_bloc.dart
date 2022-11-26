import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/exceptions/product_exception.dart";
import "package:shop/repositories/product_repository.dart";
import "package:shop/utils/logger.dart";

part "load_bookmark_event.dart";
part "load_bookmark_state.dart";

class LoadBookmarkBloc extends Bloc<LoadBookmarkEvent, LoadBookmarkState> {
  final ProductRepository productRepository;

  LoadBookmarkBloc(
    this.productRepository,
  ) : super(const LoadBookmarkInitialState()) {
    on<OnLoadBookmarkEvent>((event, emit) async {
      emit(LoadBookmarkInitialState(
        products: (state as LoadBookmarkInitialState).products,
        loading: true,
      ));

      try {
        final List<ProductEntity> products =
            await productRepository.getProductFromListIds();

        emit(LoadBookmarkInitialState(
          products: products,
          loading: false,
        ));
      } on ProductException catch (e) {
        error("LoadBookmarkBloc", data: {
          "message": e.message,
          "code": e.code,
        });

        emit(LoadBookmarkFailureState(
          e.code,
        ));
      }
    });
  }
}
