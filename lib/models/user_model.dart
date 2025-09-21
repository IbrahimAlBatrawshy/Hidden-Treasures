import 'package:flutter/material.dart';

class UserModel {
  final String userName;
  final int id;
  final String email;
  final String password;
  final AssetImage? image;

  UserModel({
    required this.userName,
    required this.id,
    required this.email,
    required this.password,
    this.image,
  });

  UserModel copyWith({
    String? userName,
    int? id,
    String? email,
    String? password,
    AssetImage? image,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      image: image ?? this.image,
    );
  }

  // Example static list of users
  static List<UserModel> users = [
    UserModel(
      id: 1,
      userName: "Mohamed Ayman",
      email: "mohameda.ayman8@gmail.com",
      password: "medo123",
      image: AssetImage("assets/images/p1.jpg"),
    ),
    UserModel(
      id: 2,
      userName: "Ali Essam",
      email: "alia.essam@gmail.com",
      password: "ali123",
      image: AssetImage("assets/images/p2.jpg"),
    ),
  ];
}
