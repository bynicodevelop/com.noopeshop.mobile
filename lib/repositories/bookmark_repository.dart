import "package:directus/directus.dart";
import "package:hive/hive.dart";
import "package:shop/inputs/product_input.dart";
import "package:shop/utils/logger.dart";

class BookmarkRepository {
  final Directus sdk;
  final Box<List<dynamic>> bookmarkBox;

  const BookmarkRepository(
    this.sdk,
    this.bookmarkBox,
  );

  Future<bool> toggleBookmark(ProductInput productInput) async {
    final List<ProductInput> bookmarks = List<ProductInput>.from(
        List<dynamic>.from(bookmarkBox.get("bookmarks") ?? []));

    info("Bookmarks", data: {
      "bookmarks": bookmarks,
    });

    final index = bookmarks.indexWhere(
      (element) => element.id == productInput.id,
    );

    if (index != -1) {
      bookmarkBox.put("bookmarks", bookmarks..removeAt(index));

      info("Bookmarks", data: {
        "bookmarks": bookmarks,
      });

      return false;
    }

    bookmarkBox.put("bookmarks", bookmarks..add(productInput));

    info("Bookmarks", data: {
      "productInput": productInput.toJson(),
      "bookmarks": bookmarks.map((e) => e.toJson()).toList(),
    });

    return true;
  }

  Future<List<ProductInput>> get bookmarks async => List<ProductInput>.from(
      List<dynamic>.from(bookmarkBox.get("bookmarks") ?? []));
}
