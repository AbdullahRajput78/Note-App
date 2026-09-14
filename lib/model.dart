import 'dart:ui';

class NoteModel {
  String title;
  String description;
  bool isFavorite;
  Color color;

  NoteModel({
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.color,
  });

}