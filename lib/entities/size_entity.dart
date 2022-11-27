import "package:equatable/equatable.dart";
import "package:hive/hive.dart";

part "size_entity.g.dart";

@HiveType(typeId: 3)
class SizeEntity extends Equatable {
  @HiveField(0)
  final String slug;

  @HiveField(1)
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
