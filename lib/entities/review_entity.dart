import "package:equatable/equatable.dart";

class ReviewEntity extends Equatable {
  final int id;
  final String title;
  final String content;
  final double rating;
  final String fullName;
  final DateTime createdAt;

  const ReviewEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.rating,
    required this.fullName,
    required this.createdAt,
  });

  factory ReviewEntity.fromJson(Map<String, dynamic> json) => ReviewEntity(
        id: json["id"] as int,
        title: json["title"] as String,
        content: json["content"] as String,
        rating: double.parse(json["rating"].toString()),
        fullName: json["full_name"] as String,
        createdAt: DateTime.parse(json["date_created"] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "rating": rating,
        "full_name": fullName,
        "date_created": createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        rating,
        fullName,
        createdAt,
      ];
}
