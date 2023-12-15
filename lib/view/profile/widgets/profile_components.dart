import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/services/auth/auth_listener.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/components/widgets/animations/animate_fade_in_down.dart';
import '../../../core/init/language/language_manager.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/services/auth/user_service.dart';
import '../../../theme/theme_provider.dart';

class ProfileComponents extends ConsumerWidget {
  const ProfileComponents({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkMode = ref.watch(darkModeProvider);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        bottom: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.language,
                  color: Colors.grey.shade500,
                  size: 24,
                ),
                label: Text(
                  LocaleKeys.editProfile_language.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              InkWell(
                onTap: () {
                  _getStartLanguageChange(context);
                },
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.langName.locale(),
                      style: TextStyle(
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Color(0xfffe0000),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.dark_mode_outlined,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_darkMode.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Switch(
                        inactiveThumbColor: Colors.grey.shade600,
                        inactiveTrackColor: Colors.grey.shade800,
                        activeColor: const Color(0xfffe0000),
                        value: darkMode,
                        onChanged: (value) {
                          ref.read(darkModeProvider.notifier).toggle();
                        }),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_notifications.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Switch(
                        inactiveThumbColor: Colors.grey.shade600,
                        inactiveTrackColor: Colors.grey.shade800,
                        activeColor: const Color(0xfffe0000),
                        value: false,
                        onChanged: (value) {
                          !value;
                        }),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.phonelink_lock,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_pinCode.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Switch(
                        inactiveThumbColor: Colors.grey.shade600,
                        inactiveTrackColor: Colors.grey.shade800,
                        activeColor: const Color(0xfffe0000),
                        value: true,
                        onChanged: (value) {
                          !value;
                        }),
                  ),
                  SizedBox(
                      width: 20.w,
                      child: const Icon(
                        Icons.lock_outlined,
                        size: 20,
                        color: Color(0xfffe0000),
                      )),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.message,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_messages.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Color(0xfffe0000),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.group_sharp,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_friends.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Color(0xfffe0000),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.interests,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_chooseInterests.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Color(0xfffe0000),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_likedMovies.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Color(0xfffe0000),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.watch_later_outlined,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_watchLater.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Color(0xfffe0000),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.history,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_watchHistory.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Color(0xfffe0000),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () async {
                  await ref.read(userServiceProvider.notifier).logOut(context);
                  Get.off(const AuthListener());
                },
                icon: Icon(
                  Icons.logout,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
                label: Text(
                  LocaleKeys.editProfile_logout.locale(),
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Color(0xfffe0000),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getStartLanguageChange(BuildContext context) {
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
  }

  TextButton _getEnLocale(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.setLocale(LanguageManager.instance!.enLocale);
        Get.updateLocale(LanguageManager.instance!.enLocale);
        Get.back();
        Get.off(const AuthListener());
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
        Get.off(const AuthListener());
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
        Get.off(const AuthListener());
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
        Get.off(const AuthListener());
      },
      child: Text(
        "Türkçe",
        maxLines: 1,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
