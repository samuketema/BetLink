// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class FirebaseUser {
  String name;
  String email;
  String profilePic;

  FirebaseUser({
    required this.name,
    required this.email,
    required this.profilePic,
  });
  
  

  FirebaseUser copyWith({
    String? name,
    String? email,
    String? profilePic,
  }) {
    return FirebaseUser(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePic': profilePic,
    };
  }

  factory FirebaseUser.fromMap(Map<String, dynamic> map) {
    return FirebaseUser(
      name: map['name'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseUser.fromJson(String source) => FirebaseUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FirebaseUser(name: $name, email: $email, profilePic: $profilePic)';

  @override
  bool operator ==(covariant FirebaseUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.profilePic == profilePic;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ profilePic.hashCode;
}
