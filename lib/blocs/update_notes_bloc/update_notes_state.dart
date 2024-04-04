import '../../data/models/note_model.dart';

abstract class UpdateNotesState {}

class NotesInitialState extends UpdateNotesState {}

class NotesUpdatedState extends UpdateNotesState {}