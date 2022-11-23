import "package:equatable/equatable.dart";

class AccountModel extends Equatable {
  final String email;
  final String password;

  const AccountModel({
    required this.email,
    required this.password,
  });

  factory AccountModel.fromJson(Map json) => AccountModel(
        email: json["email"],
        password: json["password"],
      );

  Map toJson() => {
        "email": email,
        "password": password,
      };

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
