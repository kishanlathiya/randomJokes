import 'package:flutter/material.dart';

class RandomJokes {
  final String createdAt;
  final String id;
  final String updatedAt;
  final String jokes;

  RandomJokes({
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.jokes,
  });

  factory RandomJokes.fromJson(Map<String, dynamic> json) {
    return RandomJokes(
      createdAt: json['created_at'],
      id: json['id'],
      updatedAt: json['updated_at'],
      jokes: json['value'],
    );
  }
}
