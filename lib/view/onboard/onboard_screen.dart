import 'package:cinelux/view/auth/auth_screen.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/init/language/language_manager.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../../core/components/widgets/animations/animate_fade_in_down.dart';
import '../../core/components/widgets/button/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/components/widgets/text/locale_text.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Constants.instance!.getData(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Stack(
          alignment: Alignment.center,
          children: [
            _getStartBackgroundImage(),
            _getStartScreenElements(context),
          ],
        ));
  }

  Container _getStartBackgroundImage() {
    return Container(
      width: Constants.screenWidth,
      height: Constants.screenHeight,
      color: Colors.grey.shade900,
      child: AnimateFadeInDown(
        animate: true,
        duration: 1500,
        child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset("assets/start-splash-dark.png")),
      ),
    );
  }

  SafeArea _getStartScreenElements(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 30.w,
          right: 30.w,
          top: 15.h,
          bottom: 50.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: _getStartLanguageChange(context)),
                55.verticalSpace,
                _getStartLogo(context),
              ],
            ),
            SizedBox(
                height: 110.h,
                width: double.infinity,
                child: _getStartWelcomeMessage(context)),
            _getStartButton(context),
          ],
        ),
      ),
    );
  }

  AnimateFadeInDown _getStartLanguageChange(BuildContext context) {
    return AnimateFadeInDown(
      animate: true,
      duration: 2100,
      child: TextButton.icon(
        onPressed: () {
          Get.defaultDialog(
            backgroundColor: Colors.grey.shade900,
            title: "",
            titlePadding: const EdgeInsets.all(0),
            content: Container(
              alignment: Alignment.center,
              width: 200,
              height: 300,
              child: AnimateFadeInDown(
                animate: true,
                duration: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Divider(),
                    _getEnLocale(context),
                    const Divider(),
                    _getAzLocale(context),
                    const Divider(),
                    _getRuLocale(context),
                    const Divider(),
                    _getTrLocale(context),
                    const Divider(),
                  ],
                ),
              ),
            ),
          );
        },
        icon: Icon(
          Icons.language,
          color: Colors.white,
          size: 30.w,
        ),
        label: LocaleText(
          text: LocaleKeys.langCode,
          style: Constants.myTextTheme!.bodyMedium,
        ),
      ),
    );
  }

  TextButton _getEnLocale(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.setLocale(LanguageManager.instance!.enLocale);
        Get.updateLocale(LanguageManager.instance!.enLocale);
        Get.back();
      },
      child: Text(
        "English",
        maxLines: 1,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  TextButton _getAzLocale(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.setLocale(LanguageManager.instance!.azLocale);
        Get.updateLocale(LanguageManager.instance!.azLocale);
        Get.back();
      },
      child: Text(
        "Azərbaycanca",
        maxLines: 1,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  TextButton _getRuLocale(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.setLocale(LanguageManager.instance!.ruLocale);
        Get.updateLocale(LanguageManager.instance!.ruLocale);
        Get.back();
      },
      child: Text(
        "Русский",
        maxLines: 1,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  TextButton _getTrLocale(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.setLocale(LanguageManager.instance!.trLocale);
        Get.updateLocale(LanguageManager.instance!.trLocale);
        Get.back();
      },
      child: Text(
        "Türkçe",
        maxLines: 1,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  AnimateFadeInDown _getStartLogo(BuildContext context) {
    return AnimateFadeInDown(
      animate: true,
      duration: 1900,
      child: SvgPicture.asset(
        "assets/logo/cinelux-logo-text-only.svg",
        width: 0.7.sw,
      ),
    );
  }

  Row _getStartWelcomeMessage(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _getStartDivider(context),
        20.horizontalSpace,
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getStartTextOne(),
            _getStartTextTwo(),
            _getStartTextThree(),
          ],
        ),
      ],
    );
  }

  AnimateFadeInDown _getStartDivider(BuildContext context) {
    return AnimateFadeInDown(
      animate: true,
      duration: 1400,
      child: VerticalDivider(
        width: 0,
        thickness: 7.w,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  AnimateFadeInDown _getStartTextOne() {
    return AnimateFadeInDown(
      animate: true,
      duration: 1700,
      child: LocaleText(
        text: LocaleKeys.splash_aboutTextOne,
        style: Constants.myTextTheme!.bodyLarge,
      ),
    );
  }

  AnimateFadeInDown _getStartTextTwo() {
    return AnimateFadeInDown(
      animate: true,
      duration: 1500,
      child: LocaleText(
        text: LocaleKeys.splash_aboutTextTwo,
        style: Constants.myTextTheme!.bodyLarge,
      ),
    );
  }

  AnimateFadeInDown _getStartTextThree() {
    return AnimateFadeInDown(
      animate: true,
      duration: 1300,
      child: LocaleText(
        text: LocaleKeys.splash_aboutTextThree,
        style: Constants.myTextTheme!.bodyLarge,
      ),
    );
  }

  AnimateFadeInDown _getStartButton(BuildContext context) {
    return AnimateFadeInDown(
      animate: true,
      duration: 1100,
      child: SubmitButton(
        onTap: () => Get.off(const AuthScreen()),
        child: LocaleText(
            text: LocaleKeys.splash_buttonText,
            style: Constants.myTextTheme!.labelMedium!),
      ),
    );
  }
}
