import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/blocs/notes_bloc/notes_state.dart';
import 'package:note_taking_app/data/local/local_database.dart';

import 'notes_event.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitialState()) {
    on<GetNotesEvent>(_mapGetNotesToState);
    on<DeleteNotesEvent>(_deleteNote);
    on<DeleteAllNotesEvent>(_deleteAllNotes);
    on<SearchNotesEvent>(_searchNote);
    on<InsertNotesEvent>(insertNotes);
    on<UpdateNotesEvent>(updateNotes);

  }

  Future<void> _mapGetNotesToState(
    GetNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());
    emit(
      NotesSuccessState(await LocalDatabase.getAllNotes()),
    );

      }

  Future<void> _deleteNote(
    DeleteNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesInitialState());

    final id = event.notesId;

    await LocalDatabase.deleteNote(id);
    emit(NotesDeletedState());
    add(GetNotesEvent());
  }

  Future<void> _deleteAllNotes(
    DeleteAllNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesInitialState());

    await LocalDatabase.deleteAllNotes();

    await Future.delayed(const Duration(seconds: 3));

    emit(NotesDeletedState());

    add(GetNotesEvent());
  }

  Future<void> _searchNote(
    SearchNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesInitialState());
    final query = event.query;

    emit(NotesSearchState(await LocalDatabase.searchNotes(query)));
    add(GetNotesEvent());
  }

  Future<void> insertNotes(
      InsertNotesEvent event, Emitter<NotesState> emit) async {
    LocalDatabase.insertNote(event.noteModel);
    add(GetNotesEvent());
  }

  Future<void> updateNotes(
      UpdateNotesEvent event, Emitter<NotesState> emit) async {
    LocalDatabase.updateNote(event.noteModel, event.noteModel.id!);
    add(GetNotesEvent());
  }
}
