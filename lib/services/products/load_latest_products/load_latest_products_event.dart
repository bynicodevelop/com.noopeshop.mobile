part of "load_latest_products_bloc.dart";

abstract class LoadLatestProductsEvent extends Equatable {
  const LoadLatestProductsEvent();

  @override
  List<Object> get props => [];
}

class OnLoadLatestProductsEvent extends LoadLatestProductsEvent {}
