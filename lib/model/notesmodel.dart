import 'package:flutter/material.dart';

class NoteModel {
  String title;
  String description;
  int textColor;
  int backgroundColor;
  bool isFavorite;
  bool isArchived;
  String createdAt;
  String? imagePath;

  NoteModel({
    required this.title,
    required this.description,
    required this.textColor,
    required this.backgroundColor,
    this.isFavorite = false,
    this.isArchived = false,
    required this.createdAt,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'textColor': textColor,
      'backgroundColor': backgroundColor,
      'isFavorite': isFavorite,
      'isArchived': isArchived,
      'createdAt': createdAt,
      'imagePath': imagePath,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'],
      description: json['description'],
      textColor: json['textColor'],
      backgroundColor: json['backgroundColor'],
      isFavorite: json['isFavorite'] ?? false,
      isArchived: json['isArchived'] ?? false,
      createdAt: json['createdAt'],
      imagePath: json['imagePath'],
    );
  }

  Color get textColorValue => Color(textColor);
  Color get backgroundColorValue => Color(backgroundColor);
}