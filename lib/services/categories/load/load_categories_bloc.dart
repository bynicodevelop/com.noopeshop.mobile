import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/entities/category_entity.dart";
import "package:shop/repositories/categories_repository.dart";

part "load_categories_event.dart";
part "load_categories_state.dart";

class LoadCategoriesBloc
    extends Bloc<LoadCategoriesEvent, LoadCategoriesState> {
  late CategoriesRepository categoriesRepository;

  LoadCategoriesBloc(
    this.categoriesRepository,
  ) : super(const LoadCategoriesInitialState()) {
    on<OnLoadCategoriesEvent>((event, emit) async {
      emit(LoadCategoriesInitialState(
        categories: (state as LoadCategoriesInitialState).categories,
        loading: true,
      ));

      final List<CategoryEntity> categories =
          await categoriesRepository.categories;

      emit(LoadCategoriesInitialState(
        categories: categories,
        loading: false,
      ));
    });
  }
}
