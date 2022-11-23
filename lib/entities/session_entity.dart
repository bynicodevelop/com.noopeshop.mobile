import "package:equatable/equatable.dart";

class SessionEntity extends Equatable {
  final String id;
  final String email;

  const SessionEntity({
    required this.id,
    required this.email,
  });

  factory SessionEntity.fromJson(Map<String, dynamic> json) => SessionEntity(
        id: json["id"] as String,
        email: json["email"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
      };

  @override
  List<Object> get props => [
        id,
        email,
      ];
}
