// ignore_for_file: deprecated_member_use

import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/language/locale_keys.g.dart';
import 'package:cinelux/view/genre/genre_screen.dart';
import 'package:cinelux/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../view/profile/profile_screen.dart';
import '../../../../view/search/search_screen.dart';
import '../../../init/providers/movie/helpers/genre_clear.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 12, 32, 48),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 1.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.off(const HomeScreen()),
            child: SvgPicture.asset(
              "assets/icons/bottom_bar_icons/dark/house-dark-unselected.svg",
              width: 30.w,
            ),
          ),
          InkWell(
            onTap: () {
              genreClear(
                LocaleKeys.genresMovies_Liked.locale(),
                ref,
              );
              Get.to(GenreScreen(
                genre: LocaleKeys.genresMovies_Liked.locale(),
              ));
            },
            child: SvgPicture.asset(
              "assets/icons/bottom_bar_icons/dark/fav-dark-unselected.svg",
              width: 30.w,
            ),
          ),
          InkWell(
            onTap: () {
              genreClear(
                LocaleKeys.genresMovies_NowPlaying.locale(),
                ref,
              );
              Get.off(GenreScreen(
                genre: LocaleKeys.genresMovies_NowPlaying.locale(),
              ));
            },
            child: SvgPicture.asset(
              "assets/icons/bottom_bar_icons/dark/foru-dark-unselected.svg",
              color: const Color(0xfffe0000),
              width: 40.w,
            ),
          ),
          InkWell(
            onTap: () {
              Get.off(const SearchScreen());
            },
            child: SvgPicture.asset(
              "assets/icons/bottom_bar_icons/dark/search-extend-dark-unselected.svg",
              width: 30.w,
            ),
          ),
          InkWell(
            onTap: () => Get.off(const ProfileScreen()),
            child: SvgPicture.asset(
              "assets/icons/bottom_bar_icons/dark/user-dark-unselected.svg",
              width: 30.w,
            ),
          ),
        ],
      ),
    );
  }
}
