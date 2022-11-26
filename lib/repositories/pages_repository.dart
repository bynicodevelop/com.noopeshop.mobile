import "package:directus/directus.dart";
import "package:shop/entities/page_entity.dart";
import "package:shop/exceptions/page_exception.dart";
import "package:shop/inputs/page_input.dart";

class PagesRepository {
  final Directus sdk;

  PagesRepository(
    this.sdk,
  );

  Future<PageEntity> getPageBySlug(PageInput pageInput) async {
    if (pageInput.slug == null) {
      throw PageException(
        "Slug is required",
        "slug_is_required",
      );
    }

    try {
      final response = await sdk.items("pages").readMany(
            filters: Filters({
              "slug": Filter.eq(pageInput.slug),
            }),
          );

      if (response.data.isEmpty) {
        throw PageException(
          "Page not found",
          "page_not_found",
        );
      }

      return PageEntity.fromJson(response.data.first);
    } on DirectusError catch (e) {
      String code = "unknown";

      switch (e.code) {
        case 403:
          code = "permission_denied";
          break;
      }

      throw PageException(
        e.message,
        code,
      );
    }
  }
}
