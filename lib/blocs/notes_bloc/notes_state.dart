import '../../data/models/note_model.dart';

abstract class NotesState {}

class NotesInitialState extends NotesState {}


class NotesLoadingState extends NotesState {}

class NotesSuccessState extends NotesState {
  final List<NoteModel> notes;

  NotesSuccessState(this.notes);
}

class NotesEmptyState extends NotesState {
  final List<NoteModel> notes;

  NotesEmptyState(this.notes);
}

class NotesErrorState extends NotesState {
  final String error;

  NotesErrorState(this.error);
}

class NotesDeletedState extends NotesState {}

class NotesSearchState extends NotesState {
  final List<NoteModel> notes;

  NotesSearchState(this.notes);
}