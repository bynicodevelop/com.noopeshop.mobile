import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/exceptions/product_exception.dart";
import "package:shop/repositories/product_repository.dart";

part "load_product_by_id_event.dart";
part "load_product_by_id_state.dart";

class LoadProductByIdBloc
    extends Bloc<LoadProductByIdEvent, LoadProductByIdState> {
  final ProductRepository productRepository;

  LoadProductByIdBloc(
    this.productRepository,
  ) : super(LoadProductByIdInitialState()) {
    on<OnLoadProductByIdEvent>((event, emit) async {
      emit(LoadProductByIdLoadingState());

      try {
        final ProductEntity productEntity = await productRepository.loadProduct(
          event.productId,
        );

        emit(LoadProductByIdLoadedState(
          productEntity,
        ));
      } on ProductException catch (e) {
        emit(LoadProductByIdFailureState(
          e.code,
        ));
      }
    });
  }
}
