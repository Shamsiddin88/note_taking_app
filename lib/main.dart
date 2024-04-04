import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/blocs/notes_bloc/notes_event.dart';
import 'package:note_taking_app/screen/splash/splash_screen.dart';
import 'blocs/notes_bloc/notes_bloc.dart';
import 'data/local/storage_repository.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.init();


  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NotesBloc()..add(GetNotesEvent())),
      ],
      child:
      MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false,
          scaffoldBackgroundColor: Colors.white.withOpacity(.1),
          appBarTheme: AppBarTheme(
            color: Colors.black,
          )
      ),
      home: SplashScreen(),
    );
  }
}
