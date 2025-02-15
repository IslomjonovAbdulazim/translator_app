// https://www.figma.com/community/file/1472453771022088768

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_app/language_model.dart';

String apiKey = "AIzaSyCIyR35pgtP3spCguV6MprjB1W-RSWJWTA";
Color backgroundColor = Color(0xff141F47);
Color inputColor = Color(0xff1C2D6B);

Color outputColor = Color(0xff556BBE);
Color textColor = Color(0xffFFFFFF);
Color buttonColor = Color(0xff152F8D);
Color blueColor = Color(0xff1A254F);
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
  Translation translator = Translation(apiKey: apiKey);
  LanguageModel inputLanguage = languages[0];
  LanguageModel outputLanguage = languages[1];
  TextEditingController inputController = TextEditingController();
  FocusNode inputFocus = FocusNode();
  String output = "";

  void translate() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            inputLanguage.name,
                            style: GoogleFonts.barlow(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            outputLanguage.name,
                            style: GoogleFonts.barlow(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          color: Colors.black.withValues(alpha: .3),
                          spreadRadius: 2,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      color: buttonColor,
                      padding: EdgeInsets.all(15),
                      borderRadius: BorderRadius.circular(100),
                      onPressed: () {},
                      child: Image.asset(
                        "assets/reverse.png",
                        height: 25,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: inputColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: textColor,
                          controller: inputController,
                          focusNode: inputFocus,
                          maxLength: 500,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          style: GoogleFonts.barlow(
                            fontSize: 18,
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
                          onTapOutside: (val) {
                            inputFocus.unfocus();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counter: SizedBox.shrink(),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Image.asset(
                              "assets/speaker.png",
                              height: 30,
                              color: greyButtonColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: outputColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            output,
                            style: GoogleFonts.barlow(
                              fontSize: 18,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Image.asset(
                              "assets/copy.png",
                              height: 30,
                              color: greyButtonColor,
                            ),
                          ),
                          SizedBox(width: 5),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Image.asset(
                              "assets/share.png",
                              height: 30,
                              color: greyButtonColor,
                            ),
                          ),
                          Spacer(),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Image.asset(
                              "assets/speaker.png",
                              height: 30,
                              color: greyButtonColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  fixedSize: Size.fromHeight(55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  String input = inputController.text.trim();
                  TranslationModel translation = await translator.translate(
                    text: input,
                    to: outputLanguage.code,
                  );
                  output = translation.translatedText;
                  setState(() {});
                },
                child: Center(
                  child: Text(
                    "Translate",
                    style: GoogleFonts.barlow(
                      fontSize: 20,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
