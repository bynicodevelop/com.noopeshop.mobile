part of "load_cart_bloc.dart";

abstract class LoadCartEvent extends Equatable {
  const LoadCartEvent();

  @override
  List<Object> get props => [];
}

class OnLoadCartEvent extends LoadCartEvent {}
