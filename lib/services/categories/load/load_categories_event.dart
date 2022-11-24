part of "load_categories_bloc.dart";

abstract class LoadCategoriesEvent extends Equatable {
  const LoadCategoriesEvent();

  @override
  List<Object> get props => [];
}

class OnLoadCategoriesEvent extends LoadCategoriesEvent {}
