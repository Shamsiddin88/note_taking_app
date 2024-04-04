import 'package:flutter/material.dart';
import 'package:note_taking_app/data/models/note_model_constants.dart';

class NoteModel {
  final int? id;
  final String title;
  final String noteText;
  final DateTime createdDate;
  final Color noteColor;

  NoteModel({
    this.id,
    required this.createdDate,
    required this.noteColor,
    required this.title,
    required this.noteText,
  });

  static NoteModel initialValue = NoteModel(
    title: "",
    noteText: "",
    createdDate: DateTime.now(),
    noteColor: Colors.white,
  );


  NoteModel copyWith({
    String? title,
    int? id,
    String? noteText,
    DateTime? createdDate,
    Color? noteColor,
  }) =>
      NoteModel(
        noteText: noteText ?? this.noteText,
        noteColor: noteColor ?? this.noteColor,
        createdDate: createdDate ?? this.createdDate,
        title: title?? this.title,
          id: id?? this.id

      );


  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteText: json[NoteModelConstants.noteText] as String? ?? "",
      title: json[NoteModelConstants.title] as String? ?? "",
      noteColor: Color(int.parse(json[NoteModelConstants.noteColor] as String? ?? "")),
      createdDate: DateTime.parse(json[NoteModelConstants.createdDate] as String? ?? ""),
      id: json[NoteModelConstants.id] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NoteModelConstants.noteColor: noteColor.value.toString(),
      NoteModelConstants.noteText: noteText,
      NoteModelConstants.createdDate: createdDate.toString(),
      NoteModelConstants.title: title,

    };
  }

}
