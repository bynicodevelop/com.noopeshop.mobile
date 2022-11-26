part of "load_product_by_id_bloc.dart";

abstract class LoadProductByIdEvent extends Equatable {
  const LoadProductByIdEvent();

  @override
  List<Object> get props => [];
}

class OnLoadProductByIdEvent extends LoadProductByIdEvent {
  final int productId;

  const OnLoadProductByIdEvent(
    this.productId,
  );

  @override
  List<Object> get props => [
        productId,
      ];
}
