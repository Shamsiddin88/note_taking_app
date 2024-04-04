import 'package:note_taking_app/data/models/note_model.dart';

abstract class NotesEvent {}

class GetNotesEvent extends NotesEvent {}

class DeleteNotesEvent extends NotesEvent {
  final int notesId;

  DeleteNotesEvent({required this.notesId});
}

class SearchNotesEvent extends NotesEvent {
  final String query;

  SearchNotesEvent({required this.query});
}

class DeleteAllNotesEvent extends NotesEvent {}

class InsertNotesEvent extends NotesEvent {
  InsertNotesEvent({required this.noteModel});

  final NoteModel noteModel;
}

class UpdateNotesEvent extends NotesEvent {
  UpdateNotesEvent(this.id, {required this.noteModel});

  final NoteModel noteModel;
  final int id;
}