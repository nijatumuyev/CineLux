import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinelux/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/init/model/movie_model.dart';
import '../../../../core/init/providers/movie/categories/now_playing_notifier.dart';
import '../../../movie/movie_screen.dart';
import 'trending_skeleton.dart';

class TrendingWidget extends ConsumerWidget {
  final int page = 1;
  const TrendingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(nowPlayingNotifier.notifier).fetchMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                autoPlay: true,
                height: 180.h,
                viewportFraction: 1,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                autoPlayAnimationDuration: const Duration(seconds: 2),
              ),
              itemBuilder: (context, index, realIndex) {
                Movie movie = snapshot.data![index];
                return InkWell(
                  onTap: () async {
                    final String videoId = await movie.getVideoId(movie.id!);
                    Get.off(
                      MovieScreen(
                        movie: movie,
                        videoId: videoId,
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 180.h,
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(blurRadius: 2.r, color: Colors.black26)
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, progress) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                );
                              },
                              fit: BoxFit.cover,
                              imageUrl: movie.backdropPath!),
                        ),
                      ),
                      Positioned(
                        top: 10.w,
                        left: 10.w,
                        child: Image.asset(
                          langCode == "en-EN"
                              ? "assets/logo/cinelux-selected-en.png"
                              : langCode == "ru-RU"
                                  ? "assets/logo/cinelux-selected-ru.png"
                                  : "assets/logo/cinelux-selected-az.png",
                          width: 0.225.sw,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          width: double.infinity,
                          height: 70.h,
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, bottom: 10.w),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade700, width: 3.r),
                              left: BorderSide(
                                  color: Colors.grey.shade700, width: 3.r),
                              right: BorderSide(
                                  color: Colors.grey.shade700, width: 3.r),
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.r),
                                bottomRight: Radius.circular(15.r)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(1),
                                ]),
                          ),
                          child: Text(
                            movie.title!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const TrendingWidgetSkeleton();
        }
      },
    );
  }
}
