import "package:directus/directus.dart";
import "package:shop/entities/category_entity.dart";

class CategoriesRepository {
  final Directus sdk;

  const CategoriesRepository(
    this.sdk,
  );

  Future<List<CategoryEntity>> get categories async {
    final response = await sdk.items("categories").readMany(
          query: Query(
            sort: [
              "order",
            ],
          ),
          filters: Filters(
            {
              "status": Filter.eq("published"),
            },
          ),
        );

    return response.data
        .map((e) => CategoryEntity.fromJson(e))
        .toList(growable: false);
  }
}
