import "package:equatable/equatable.dart";

class AccountEntity extends Equatable {
  final String id;
  final String email;

  const AccountEntity({
    required this.id,
    required this.email,
  });

  factory AccountEntity.fromJson(Map<String, dynamic> json) => AccountEntity(
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
