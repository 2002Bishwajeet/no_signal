import 'dart:convert';

class UserFields {
  static const String id = "\$id";
  static const String name = "name";
  static const String email = "email";
}

class User {
  final String id;
  final String email;
  final String? name;
  User({
    required this.id,
    required this.email,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['\$id'],
      email: map['email'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
