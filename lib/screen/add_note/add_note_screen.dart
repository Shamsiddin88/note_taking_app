import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/blocs/notes_bloc/notes_bloc.dart';
import 'package:note_taking_app/blocs/notes_bloc/notes_event.dart';
import 'package:note_taking_app/data/local/local_database.dart';
import 'package:note_taking_app/data/local/storage_repository.dart';
import 'package:note_taking_app/data/models/note_model.dart';
import 'package:note_taking_app/utils/size/size_utils.dart';
import 'package:note_taking_app/utils/styles/app_text_style.dart';

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}
NoteModel note=NoteModel.initialValue;

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    note=note.copyWith(noteColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],createdDate: DateTime.now());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            20.getH(),
            TextFormField(
              onChanged: (v){note=note.copyWith(title: v);},
              style: AppTextStyle.interMedium.copyWith(color: Colors.white),
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: AppTextStyle.interMedium.copyWith(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(width: 1, color: Colors.orangeAccent)),
              ),
            ),
            20.getH(),
            TextFormField(
              onChanged: (v){note=note.copyWith(noteText: v);},
              style: AppTextStyle.interMedium.copyWith(color: Colors.white),
              keyboardType: TextInputType.text,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Input your Note",
                labelStyle: AppTextStyle.interMedium.copyWith(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(width: 3, color: Colors.orangeAccent)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<NotesBloc>().add(InsertNotesEvent(noteModel: note));
                Navigator.pop(context);
                setState(() {
                });
              },
              child: Text("Add note"),
            ),
          ],
        ),
      ),
    );
  }
}
