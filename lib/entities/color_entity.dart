import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:hive/hive.dart";

part "color_entity.g.dart";

@HiveType(typeId: 1)
class ColorEntity extends Equatable {
  @HiveField(0)
  final String slug;

  @HiveField(1)
  final Color value;

  const ColorEntity({
    required this.slug,
    required this.value,
  });

  factory ColorEntity.fromJson(Map<String, dynamic> json) => ColorEntity(
        slug: json["slug"] as String,
        value: json["value"] as Color,
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
