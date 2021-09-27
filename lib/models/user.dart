import 'dart:convert';

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

class UserDetails {
  final String id;
  final String email;
  final String name;
  final String bio;
  final String? image;
  UserDetails({
    required this.id,
    required this.email,
    required this.name,
    required this.bio,
    this.image,
  });

  UserDetails copyWith({
    String? id,
    String? email,
    String? name,
    String? bio,
    String? image,
  }) {
    return UserDetails(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'bio': bio,
      'image': image,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      bio: map['bio'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDetails(id: $id, email: $email, name: $name, bio: $bio, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetails &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.bio == bio &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        bio.hashCode ^
        image.hashCode;
  }
}
