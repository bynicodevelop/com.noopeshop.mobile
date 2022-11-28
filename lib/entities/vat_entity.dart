import "package:equatable/equatable.dart";
import "package:hive/hive.dart";

part "vat_entity.g.dart";

@HiveType(typeId: 7)
class VatEntity extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String label;

  @HiveField(2)
  final double value;

  const VatEntity({
    required this.id,
    required this.label,
    required this.value,
  });

  factory VatEntity.fromJson(Map<String, dynamic> json) => VatEntity(
        id: json["id"] as int,
        label: json["label"] as String,
        value: json["value"] as double,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "value": value,
      };

  @override
  List<Object?> get props => [
        id,
        label,
        value,
      ];
}
