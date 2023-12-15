import 'package:flutter/widgets.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager? get instance {
    _instance ??= LanguageManager._init();
    return _instance;
  }

  LanguageManager._init();

  final enLocale = const Locale("en", "US");
  final azLocale = const Locale("az", "AZ");
  final trLocale = const Locale("tr", "TR");
  final ruLocale = const Locale("ru", "RU");
  List<Locale> get supportedLocales => [enLocale, azLocale, ruLocale, trLocale];
}
