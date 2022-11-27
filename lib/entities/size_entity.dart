import "package:equatable/equatable.dart";

class SizeEntity extends Equatable {
  final String slug;
  final String value;

  const SizeEntity({
    required this.slug,
    required this.value,
  });

  factory SizeEntity.fromJson(Map<String, dynamic> json) => SizeEntity(
        slug: json["slug"] as String,
        value: json["value"] as String,
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "value": value,
      };

  @override
  List<Object?> get props => [
        slug,
        value,
      ];
}
