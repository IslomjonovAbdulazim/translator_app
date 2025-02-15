import 'package:google_cloud_translation/google_cloud_translation.dart';

void main() async {
  final translation = Translation(
    apiKey: "AIzaSyCIyR35pgtP3spCguV6MprjB1W-RSWJWTA",
  );

  final res = await translation.translate(text: "I am reading a book", to: "uz");
  print(res.translatedText);
}
