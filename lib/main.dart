// https://www.figma.com/community/file/1472453771022088768

import 'package:flutter/material.dart';

Color backgroundColor = Color(0xff141F47);
Color inputColor = Color(0xff1C2D6B);
Color outputColor = Color(0xff556BBE);
Color whiteColor = Color(0xffFFFFFF);
Color buttonColor = Color(0xff152F8D);
Color greyButtonColor = Color(0xffA1A9C8);
Color greyTextColor = Color(0xffBCC7EF);

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputLanguage = "English";
  String outputLanguage = "Russian";
  TextEditingController input = TextEditingController();
  String output = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
    );
  }
}
