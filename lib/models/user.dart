import 'dart:typed_data';

/// [ServerUser]
/// This model will contain
class ServerUser {
  final String id;
  final String email;
  final String name;
  final String bio;
  final String? imgId;
  ServerUser({
    required this.id,
    required this.email,
    required this.name,
    required this.bio,
    this.imgId,
  });

  ServerUser copyWith({
    String? id,
    String? email,
    String? name,
    String? bio,
    String? imgId,
  }) {
    return ServerUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      imgId: imgId ?? this.imgId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'bio': bio,
      'imgId': imgId,
    };
  }

  factory ServerUser.fromMap(Map<String, dynamic> map) {
    return ServerUser(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      bio: map['bio'],
      imgId: map['imgId'],
    );
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServerUser &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.bio == bio &&
        other.imgId == imgId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        bio.hashCode ^
        imgId.hashCode;
  }
}

class LocalUser {
  final String id;
  final String email;
  final String name;
  final String bio;
  final Uint8List? image;
  LocalUser({
    required this.id,
    required this.email,
    required this.name,
    required this.bio,
    this.image,
  });
}


/// [NoSignalUser]
///  A normal user model containing all the neccessary data to be used in the app
/// This model will contains as described below
class NoSignalUser {
  final String? id;
  final String? name;
  final String? email;
  final String? bio;
  final Uint8List? image;
  final String? imgId;
  NoSignalUser({
    this.id,
    this.name,
    this.email,
    this.bio,
    this.image,
    this.imgId,
  });

  NoSignalUser copyWith({
    String? id,
    String? name,
    String? email,
    String? bio,
    Uint8List? image,
    String? imgId,
  }) {
    return NoSignalUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      image: image ?? this.image,
      imgId: imgId ?? this.imgId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'imgId': imgId,
    };
  }

  factory NoSignalUser.fromMap(Map<String, dynamic> map) {
    return NoSignalUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      bio: map['bio'],
      imgId: map['imgId'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoSignalUser &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.bio == bio &&
        other.image == image &&
        other.imgId == imgId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        image.hashCode ^
        imgId.hashCode;
  }
}
