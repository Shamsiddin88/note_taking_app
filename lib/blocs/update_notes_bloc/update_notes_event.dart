import 'package:note_taking_app/data/models/note_model.dart';

abstract class UpdateNotesEvent {}


class UpdatingNotesEvent extends UpdateNotesEvent {
  final NoteModel note;
  final int id;

  UpdatingNotesEvent({required this.note, required this.id});}


