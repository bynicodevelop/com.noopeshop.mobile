part of "load_latest_products_bloc.dart";

abstract class LoadLatestProductsState extends Equatable {
  const LoadLatestProductsState();

  @override
  List<Object> get props => [];
}

class LoadLatestProductsInitialState extends LoadLatestProductsState {
  final List<ProductEntity> products;
  final bool loading;

  const LoadLatestProductsInitialState({
    this.products = const [],
    this.loading = true,
  });

  @override
  List<Object> get props => [
        products,
        loading,
      ];
}
