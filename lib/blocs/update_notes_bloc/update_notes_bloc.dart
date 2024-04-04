import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/blocs/update_notes_bloc/update_notes_event.dart';
import 'package:note_taking_app/blocs/update_notes_bloc/update_notes_state.dart';
import 'package:note_taking_app/screen/add_note/add_note_screen.dart';
import '../../data/local/local_database.dart';

class UpdateNotesBloc extends Bloc<UpdateNotesEvent, UpdateNotesState> {
  UpdateNotesBloc() : super(NotesInitialState()) {
    on<UpdatingNotesEvent>(_updateNote);
  }
  Future<void> _updateNote(
      UpdatingNotesEvent event,
      Emitter<UpdateNotesState> emit,
      ) async {
    emit(NotesInitialState());

      await LocalDatabase.updateNote(event.note, event.id);
      emit(NotesUpdatedState());
    }


  }




