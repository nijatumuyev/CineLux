import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinelux/core/components/widgets/bottom_bar/bottom_nav_bar.dart';
import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/view/home/widgets/categories/category.dart';
import 'package:cinelux/view/profile/profile_screen.dart';
import 'package:cinelux/view/search/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/init/language/locale_keys.g.dart';
import 'widgets/trending/trending.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 32, 43),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 12, 32, 48),
        centerTitle: true,
        leadingWidth: 60.w,
        leading: Center(
          child: InkWell(
            onTap: () {
              Get.to(const ProfileScreen());
            },
            child: Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(1.r),
              decoration: BoxDecoration(
                  color: const Color(0xfffe0000),
                  borderRadius: BorderRadius.circular(30.r)),
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    FirebaseAuth.instance.currentUser!.photoURL!),
              ),
            ),
          ),
        ),
        title: SvgPicture.asset(
          "assets/logo/cinelux-logo-text-only.svg",
          width: 0.45.sw,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const SearchScreen());
              },
              color: const Color(0xfffe0000),
              iconSize: 32.sp,
              icon: const Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 10.h,
          ),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              child: const TrendingWidget(),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Column(
                children: [
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Popular.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_TopRated.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Upcoming.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_SciFi.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Crime.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Drama.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_History.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Mystery.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Horror.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Action.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Fantasy.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Comedy.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Animation.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Adventure.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Family.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Documentary.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Music.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Romance.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Thriller.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_War.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_Western.locale(),
                  ),
                  CategoryWidget(
                    genre: LocaleKeys.genresMovies_TVMovie.locale(),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
