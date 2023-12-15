import 'package:awesome_rating/awesome_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/language/locale_keys.g.dart';
import 'package:cinelux/view/movie/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/init/model/movie_model.dart';
import '../../../core/init/providers/movie/helpers/similar_detector.dart';
import 'similar_skeleton.dart';

class SimilarWidget extends ConsumerStatefulWidget {
  final String? genre;
  final int? thisMovieId;
  const SimilarWidget({
    Key? key,
    required this.genre,
    required this.thisMovieId,
  }) : super(key: key);

  @override
  ConsumerState<SimilarWidget> createState() => _SimilarWidgetState();
}

class _SimilarWidgetState extends ConsumerState<SimilarWidget> {
  @override
  Widget build(BuildContext context) {
    var datas = similarDetector(widget.genre!, ref);

    return FutureBuilder(
      future: datas,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.movieScreen_similarMovies.locale(),
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w300),
              ),
              10.verticalSpace,
              SizedBox(
                width: double.infinity,
                height: 270.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    if (snapshot.data![index].id == widget.thisMovieId) {
                      snapshot.data!.remove(snapshot.data![index]);
                    }
                    Movie movie = snapshot.data![index];
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final String videoId =
                                      await movie.getVideoId(movie.id!);
                                  Get.off(
                                    MovieScreen(
                                      movie: movie,
                                      videoId: videoId,
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 140.w,
                                  height: 170.h,
                                  padding: EdgeInsets.all(3.w),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade600),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: movie.posterPath!,
                                    progressIndicatorBuilder:
                                        (context, url, progress) {
                                      return Container(
                                        width: 134.w,
                                        height: 164.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade900),
                                        child: SizedBox(
                                          width: 35.w,
                                          height: 35.w,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 3.w, right: 3.w, bottom: 3.h),
                                padding: EdgeInsets.only(
                                    left: 4.w,
                                    right: 4.w,
                                    top: 3.h,
                                    bottom: 3.h),
                                width: 134.w,
                                height: 36.h,
                                alignment: Alignment.center,
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                                child: Text(
                                  movie.title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.w,
                              right: 4.w,
                              top: 4.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        size: 12.sp,
                                        starCount: 5,
                                        spacing: 2.w,
                                        color: Colors.red,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        size: 14.sp,
                                        color: Colors.red,
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
                                        color: Colors.red,
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
                                  height: 50.h,
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
          return const SimilarSkeleton();
        }
      },
    );
  }
}
