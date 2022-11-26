import "package:directus/directus.dart";
import "package:hive/hive.dart";
import "package:shop/inputs/product_input.dart";

class BookmarkRepository {
  final Directus sdk;
  final Box<List<int>> bookmarkBox;

  const BookmarkRepository(
    this.sdk,
    this.bookmarkBox,
  );

  Future<bool> toggleBookmark(ProductInput productInput) async {
    final List<int> bookmarks = bookmarkBox.get("bookmarks") ?? [];

    if (!bookmarks.contains(productInput.id)) {
      bookmarks.add(productInput.id);

      return true;
    }

    bookmarks.remove(productInput.id);

    return false;
  }

  Future<List<int>> get bookmarks async {
    return bookmarkBox.get("bookmarks") ?? [];
  }
}
