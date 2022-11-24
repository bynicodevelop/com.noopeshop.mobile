import "package:equatable/equatable.dart";

class CategoryEntity extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String description;
  final int order;

  const CategoryEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.order,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
        id: json["id"] as int,
        title: json["title"] as String,
        slug: json["slug"] as String,
        description: json["description"] as String,
        order: json["order"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "order": order,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        description,
        order,
      ];
}
