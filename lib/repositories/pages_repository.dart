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
    // TODO: control input slug
    try {
      final response = await sdk.items("pages").readMany(
            filters: Filters({
              "slug": Filter.eq(pageInput.slug),
            }),
          );

      // TODO: Si pas de contenu ?
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
