import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/data/local/local_database.dart';
import 'package:note_taking_app/data/models/note_model.dart';
import 'package:note_taking_app/screen/add_note/add_note_screen.dart';
import 'package:note_taking_app/screen/update/update_note_screen.dart';
import 'package:note_taking_app/utils/size/size_utils.dart';
import 'package:note_taking_app/utils/styles/app_text_style.dart';

import '../../blocs/notes_bloc/notes_bloc.dart';
import '../../blocs/notes_bloc/notes_event.dart';
import '../../blocs/notes_bloc/notes_state.dart';
import '../../data/local/storage_repository.dart';
import '../../utils/images/app_images.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    bool isVisible = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes",
          style: AppTextStyle.interMedium
              .copyWith(color: Colors.white, fontSize: 43),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(.3),
              ),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          21.getW(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(.3),
              ),
              child: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
            ),
          ),
          21.getW(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  if (state is NotesErrorState) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  if (state is NotesInitialState) {
                    return const CircularProgressIndicator();
                  } else if (state is NotesSuccessState) {
                    return Column(
                      children: [
                        TextFormField(
                          onChanged: (e) {
                            context
                                .read<NotesBloc>()
                                .add(SearchNotesEvent(query: e));
                          },
                          style: AppTextStyle.interMedium
                              .copyWith(color: Colors.white),
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "Search",
                            labelStyle: AppTextStyle.interMedium
                                .copyWith(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.orangeAccent)),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              context
                                  .read<NotesBloc>()
                                  .add(DeleteAllNotesEvent());
                            },
                            child: Text(
                              "Delete All",
                              style: AppTextStyle.interBold
                                  .copyWith(color: Colors.white),
                            )),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.notes.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateNoteScreen(
                                                    note: state.notes[index])));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.all(16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: state.notes[index].noteColor),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          state.notes[index].noteText,
                                          style: AppTextStyle.interBold
                                              .copyWith(color: Colors.white),
                                        )),
                                        IconButton(
                                            onPressed: () {
                                              context.read<NotesBloc>().add(
                                                  DeleteNotesEvent(
                                                      notesId: state
                                                          .notes[index].id!));
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is NotesErrorState) {
                    return Text(state.error);
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.emptyNotes),
                        10.getH(),
                        Text(
                          "Create your first note !",
                          style: AppTextStyle.interRegular
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(.2),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
