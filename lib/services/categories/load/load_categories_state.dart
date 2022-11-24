part of "load_categories_bloc.dart";

abstract class LoadCategoriesState extends Equatable {
  const LoadCategoriesState();

  @override
  List<Object> get props => [];
}

class LoadCategoriesInitialState extends LoadCategoriesState {
  final bool loading;
  final List<CategoryEntity> categories;

  const LoadCategoriesInitialState({
    this.categories = const [],
    this.loading = true,
  });

  @override
  List<Object> get props => [
        categories,
        loading,
      ];
}
