import 'package:equatable/equatable.dart';


class LanguageModel extends Equatable {
  final String code;
  final String name;
  final String locale;

  const LanguageModel({
    required this.code,
    required this.name,
    required this.locale,
  });

  @override
  List get props => [code];
}

List<LanguageModel> languages = [
  LanguageModel(code: "en", name: "English", locale: "en-US"),
  LanguageModel(code: "uz", name: "Uzbek", locale: "uz-UZ"),
  LanguageModel(code: "ru", name: "Russian", locale: "ru-RU"),
  LanguageModel(code: "zh", name: "Mandarin", locale: "zh-CN"),
  LanguageModel(code: "es", name: "Spanish", locale: "es-ES"),
  LanguageModel(code: "fr", name: "French", locale: "fr-FR"),
  LanguageModel(code: "de", name: "German", locale: "de-DE"),
  LanguageModel(code: "ja", name: "Japanese", locale: "ja-JP"),
  LanguageModel(code: "ko", name: "Korean", locale: "ko-KR"),
  LanguageModel(code: "tr", name: "Turkish", locale: "tr-TR"),
];
