import "package:equatable/equatable.dart";

class PageEntity extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String content;

  const PageEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
  });

  factory PageEntity.fromJson(Map<String, dynamic> json) => PageEntity(
        id: json["id"] as int,
        title: json["title"] as String,
        slug: json["slug"] as String,
        content: json["content"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "content": content,
      };

  @override
  List<Object> get props => [
        id,
        title,
        slug,
        content,
      ];
}
