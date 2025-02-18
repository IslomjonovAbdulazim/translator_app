// https://www.figma.com/community/file/1472453771022088768

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
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


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
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
  FlutterTts tts = FlutterTts();
  LanguageModel inputLanguage = languages[0];
  LanguageModel outputLanguage = languages[1];
  TextEditingController inputController = TextEditingController();
  FocusNode inputFocus = FocusNode();
  String output = "";

  Future<void> translate() async {
    String input = inputController.text.trim();
    TranslationModel translation = await translator.translate(
      text: input,
      to: outputLanguage.code,
    );
    output = translation.translatedText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
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
                          child: DropdownButton<LanguageModel>(
                            dropdownColor: blueColor,
                            borderRadius: BorderRadius.circular(15),
                            onChanged: (val) {
                              if (val == null || val == outputLanguage) return;
                              inputLanguage = val;
                              setState(() {});
                              translate();
                            },
                            style: GoogleFonts.barlow(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            icon: SizedBox.shrink(),
                            underline: SizedBox.shrink(),
                            value: inputLanguage,
                            items: languages
                                .map(
                                  (lan) => DropdownMenuItem<LanguageModel>(
                                    value: lan,
                                    child: Text(
                                      lan.name,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButton<LanguageModel>(
                              alignment: Alignment.centerRight,
                              dropdownColor: blueColor,
                              borderRadius: BorderRadius.circular(15),
                              onChanged: (val) {
                                if (val == null || val == inputLanguage) return;
                                outputLanguage = val;
                                setState(() {});
                                translate();
                              },
                              style: GoogleFonts.barlow(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              icon: SizedBox.shrink(),
                              underline: SizedBox.shrink(),
                              value: outputLanguage,
                              items: languages
                                  .map(
                                    (lan) => DropdownMenuItem<LanguageModel>(
                                      value: lan,
                                      child: Text(
                                        lan.name,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
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
                      onPressed: () {
                        String input = inputController.text.trim();
                        inputController.text = output;
                        output = input;
                        LanguageModel language = inputLanguage;
                        inputLanguage = outputLanguage;
                        outputLanguage = language;
                        setState(() {});
                      },
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
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: inputColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        inputLanguage.name,
                        style: GoogleFonts.barlow(
                          color: greyTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          cursorColor: textColor,
                          controller: inputController,
                          focusNode: inputFocus,
                          maxLength: 500,
                          onSubmitted: (va) {
                            translate();
                          },
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
                          textCapitalization: TextCapitalization.sentences,
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
                            onPressed: () async {
                              await tts.stop();
                              await tts.setLanguage(inputLanguage.locale);
                              tts.speak(inputController.text.trim());
                            },
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
                  translate();
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
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: outputColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        outputLanguage.name,
                        style: GoogleFonts.barlow(
                          color: greyTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                            onPressed: () async {
                              if (output.isEmpty) return;
                              await FlutterClipboard.copy(output);
                            },
                            child: Image.asset(
                              "assets/copy.png",
                              height: 30,
                              color: greyButtonColor,
                            ),
                          ),
                          SizedBox(width: 5),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              String input = inputController.text.trim();
                              if (output.isEmpty || input.isEmpty) return;
                              await Share.share('🌍 Translation 🌍\n\n'
                                  '🔹 From: ${inputLanguage.name}\n'
                                  '📝 $input\n\n'
                                  '🔹 To: ${outputLanguage.name}\n'
                                  '🗣️ $output\n\n'
                                  '📲 Shared via D4 Translator App');
                            },
                            child: Image.asset(
                              "assets/share.png",
                              height: 30,
                              color: greyButtonColor,
                            ),
                          ),
                          Spacer(),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              await tts.stop();
                              await tts.setLanguage(outputLanguage.locale);
                              tts.speak(output);
                            },
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
            ],
          ),
        ),
      ),
    );
  }
}







