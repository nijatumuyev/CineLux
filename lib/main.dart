import 'package:cinelux/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app/app_constants.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/services/auth/auth_listener.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';

import 'theme/theme_provider.dart';
import 'theme/themes.dart';

bool hasData = false;
late String langCode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();
  runApp(ProviderScope(
    child: EasyLocalization(
        supportedLocales: LanguageManager.instance!.supportedLocales,
        path: Constants.langAssetPath,
        child: const CineLux()),
  ));
}

class CineLux extends ConsumerWidget {
  const CineLux({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String countryCode =
        EasyLocalization.of(context)!.currentLocale!.countryCode!;
    langCode = switch (countryCode) {
      "TR" => "tr-TR",
      "AZ" => "az-AZ",
      "RU" => "ru-RU",
      _ => "en-EN"
    };
    var darkMode = ref.watch(darkModeProvider);
    Constants.instance!.getData(context);
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
          useInheritedMediaQuery: true,
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          darkTheme: darkTheme,
          theme: lightTheme,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          title: 'CineLux',
          home: const AuthListener()),
    );
  }
}
