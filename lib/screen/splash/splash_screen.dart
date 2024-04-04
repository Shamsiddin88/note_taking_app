import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_taking_app/screen/notes/notes_screen.dart';

import '../../utils/images/app_images.dart';
import '../../utils/size/size_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return NotesScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Lottie.asset(AppImages.loading),
        ),
      ),
    );
  }
}