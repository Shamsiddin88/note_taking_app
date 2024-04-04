import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/data/local/local_database.dart';
import 'package:note_taking_app/data/models/note_model.dart';
import 'package:note_taking_app/utils/size/size_utils.dart';
import 'package:note_taking_app/utils/styles/app_text_style.dart';

import '../../blocs/notes_bloc/notes_bloc.dart';
import '../../blocs/notes_bloc/notes_event.dart';
import '../../blocs/update_notes_bloc/update_notes_bloc.dart';

class UpdateNoteScreen extends StatefulWidget {

  UpdateNoteScreen({Key? key, required this.note}) : super(key: key);
  NoteModel note;


  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}



class _UpdateNoteScreenState extends State<UpdateNoteScreen> {


  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
    TextEditingController(text: widget.note.title);

    final TextEditingController nameController =
    TextEditingController(text: widget.note.noteText);
    widget.note=widget.note.copyWith(noteColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],createdDate: DateTime.now());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            20.getH(),
            TextFormField(
              controller: titleController,
              onChanged: (v){widget.note=widget.note.copyWith(title: v);},
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
              controller: nameController,
              onChanged: (v){widget.note=widget.note.copyWith(noteText: v);},
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
                debugPrint("NOTEEE${widget.note.id}");
                await LocalDatabase.updateNote(widget.note, widget.note.id!);
                context.read<NotesBloc>().add(UpdateNotesEvent(widget.note.id!, noteModel: widget.note));

                Navigator.pop(context);
                setState(() {
                });
              },
              child: Text("Update note"),
            ),
          ],
        ),
      ),
    );
  }
}
