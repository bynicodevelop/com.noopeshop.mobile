import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/repositories/product_repository.dart";

part "load_latest_products_event.dart";
part "load_latest_products_state.dart";

class LoadLatestProductsBloc
    extends Bloc<LoadLatestProductsEvent, LoadLatestProductsState> {
  late ProductRepository productRepository;

  LoadLatestProductsBloc(
    this.productRepository,
  ) : super(const LoadLatestProductsInitialState()) {
    on<OnLoadLatestProductsEvent>((event, emit) async {
      emit(LoadLatestProductsInitialState(
        products: (state as LoadLatestProductsInitialState).products,
        loading: true,
      ));

      final List<ProductEntity> products =
          await productRepository.getLatestProducts();

      emit(LoadLatestProductsInitialState(
        products: products,
        loading: false,
      ));
    });
  }
}
