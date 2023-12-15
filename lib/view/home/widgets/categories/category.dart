import 'package:awesome_rating/awesome_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinelux/view/genre/genre_screen.dart';
import 'package:cinelux/view/movie/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/init/model/movie_model.dart';
import '../../../../core/init/providers/movie/helpers/genre_clear.dart';
import '../../../../core/init/providers/movie/helpers/genre_detector.dart';
import 'category_skeleton.dart';

class CategoryWidget extends ConsumerStatefulWidget {
  final String? genre;
  const CategoryWidget({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  ConsumerState<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends ConsumerState<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: genreDetectorFetchMovies(widget.genre!, ref),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.genre!,
                    style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    onPressed: () async {
                      await genreClear(
                        widget.genre!,
                        ref,
                      );
                      Get.to(
                          GenreScreen(
                            genre: widget.genre,
                          ),
                          transition: Transition.cupertinoDialog);
                    },
                    icon: const Icon(
                      Icons.grid_view_rounded,
                    ),
                    color: Colors.grey.shade500,
                    iconSize: 27.sp,
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 260.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Movie movie = snapshot.data![index];
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              final String videoId =
                                  await movie.getVideoId(movie.id!);
                              Get.to(
                                MovieScreen(
                                  movie: movie,
                                  videoId: videoId,
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  width: 140.w,
                                  height: 170.h,
                                  padding: EdgeInsets.all(3.r),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade700),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: movie.posterPath!,
                                    progressIndicatorBuilder:
                                        (context, url, progress) {
                                      return Container(
                                        width: 35.w,
                                        height: 35.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade900),
                                        child: SizedBox(
                                          width: 35.w,
                                          height: 35.w,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Color(0xfffe0000),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    width: double.infinity,
                                    height: 120.h,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade700,
                                            width: 3.r),
                                        left: BorderSide(
                                            color: Colors.grey.shade700,
                                            width: 3.r),
                                        right: BorderSide(
                                            color: Colors.grey.shade700,
                                            width: 3.r),
                                      ),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.1),
                                            Colors.black.withOpacity(0.2),
                                            Colors.black.withOpacity(0.3),
                                            Colors.black.withOpacity(0.4),
                                            Colors.black.withOpacity(0.5),
                                            Colors.black.withOpacity(0.6),
                                            Colors.black.withOpacity(0.7),
                                            Colors.black.withOpacity(0.8),
                                            Colors.black.withOpacity(0.9),
                                            Colors.black,
                                            Colors.black,
                                            Colors.black,
                                          ]),
                                    ),
                                    child: Text(
                                      movie.title!,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.w,
                              right: 4.w,
                              top: 4.h,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 130,
                                  height: 15,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AwesomeStarRating(
                                        allowHalfRating: true,
                                        borderColor: Colors.grey.shade400,
                                        size: 14.sp,
                                        starCount: 5,
                                        spacing: 2.w,
                                        color: const Color(0xfffe0000),
                                        rating: movie.voteAverage! / 2,
                                      ),
                                      15.horizontalSpace,
                                      Text(
                                        movie.voteAverage.toString(),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade300),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  height: 20,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        size: 14.sp,
                                        color: const Color(0xfffe0000),
                                      ),
                                      5.horizontalSpace,
                                      Text(
                                        movie.releaseDate!.split("-")[0],
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade300),
                                      ),
                                      VerticalDivider(
                                        thickness: 1,
                                        color: Colors.grey.shade500,
                                      ),
                                      Icon(
                                        Icons.play_circle_outline_sharp,
                                        size: 14.sp,
                                        color: const Color(0xfffe0000),
                                      ),
                                      5.horizontalSpace,
                                      Text(
                                        movie.voteCount.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade300),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 130.w,
                                  height: 55.h,
                                  child: Text(
                                    movie.genreView,
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const CategoryWidgetSkeleton();
        }
      },
    );
  }
}
