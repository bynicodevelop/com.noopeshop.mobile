import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

class ColorEntity extends Equatable {
  final String slug;
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
