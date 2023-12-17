// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_rating/awesome_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinelux/core/components/widgets/bottom_bar/bottom_nav_bar.dart';
import 'package:cinelux/core/init/providers/movie/helpers/genre_clear.dart';
import 'package:cinelux/view/movie/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/init/model/movie_model.dart';
import '../../core/init/providers/movie/helpers/genre_detector.dart';

class GenreScreen extends ConsumerStatefulWidget {
  final String? genre;
  const GenreScreen({
    this.genre,
    super.key,
  });

  @override
  ConsumerState<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends ConsumerState<GenreScreen> {
  @override
  Widget build(BuildContext context) {
    final paginationState = genreDetectorWatch(widget.genre!, ref);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 32, 43),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 32, 48),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          widget.genre!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey.shade300,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Builder(
          builder: (ctx) {
            if (paginationState.refreshError) {
              return _ErrorBody(
                message: paginationState.errorMessage!,
                genre: widget.genre,
              );
            } else if (paginationState.movies!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: () {
                genreClear(widget.genre!, ref);
                return genreDetectorFetchMovies(widget.genre!, ref);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5.h, left: 8.w, right: 8.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 7.w,
                    mainAxisSpacing: 5.w,
                    childAspectRatio: 0.465,
                  ),
                  itemCount: paginationState.movies!.length,
                  itemBuilder: (context, index) {
                    genreDetectorHandleScroll(widget.genre!, ref, index);

                    return _MovieBox(movie: paginationState.movies![index]);
                  },
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class _ErrorBody extends ConsumerWidget {
  const _ErrorBody({
    Key? key,
    required this.message,
    required this.genre,
  }) : super(key: key);

  final String message;
  final String? genre;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () => genreDetectorFetchMovies(genre!, ref),
            child: const Text("Try again"),
          ),
        ],
      ),
    );
  }
}

class _MovieBox extends StatelessWidget {
  final Movie? movie;

  const _MovieBox({
    Key? key,
    this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            final String videoId = await movie!.getVideoId(movie!.id!);
            Get.to(
              MovieScreen(
                movie: movie!,
                videoId: videoId,
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 220.h,
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(color: Colors.grey.shade600),
                child: CachedNetworkImage(
                  imageUrl: movie!.posterPath!,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Container(
                      width: 35.w,
                      height: 35.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.grey.shade900),
                      child: SizedBox(
                        width: 35.w,
                        height: 35.w,
                        child: const CircularProgressIndicator(
                          color: Colors.red,
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
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade700, width: 3.r),
                      left: BorderSide(color: Colors.grey.shade700, width: 3.r),
                      right:
                          BorderSide(color: Colors.grey.shade700, width: 3.r),
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
                          Colors.black.withOpacity(0.9),
                          Colors.black,
                          Colors.black,
                          Colors.black,
                        ]),
                  ),
                  child: Text(
                    movie!.title!,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AwesomeStarRating(
                    allowHalfRating: true,
                    borderColor: Colors.grey.shade400,
                    size: 16.sp,
                    starCount: 5,
                    spacing: 2.w,
                    color: Colors.red,
                    rating: movie!.voteAverage! / 2,
                  ),
                  15.horizontalSpace,
                  Text(
                    movie!.voteAverage.toString(),
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade300),
                  ),
                ],
              ),
              1.verticalSpace,
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 16.sp,
                    color: Colors.red,
                  ),
                  8.horizontalSpace,
                  Text(
                    movie!.releaseDate!.split("-")[0],
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade300),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: Colors.grey.shade500,
                  ),
                  Icon(
                    Icons.play_circle_outline_sharp,
                    size: 16.sp,
                    color: Colors.red,
                  ),
                  8.horizontalSpace,
                  Text(
                    movie!.voteCount.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade300),
                  ),
                ],
              ),
              3.verticalSpace,
              Text(
                movie!.genreView,
                style: TextStyle(fontSize: 11.sp),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _FrontBanner extends StatelessWidget {
  const _FrontBanner({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
      alignment: Alignment.center,
      color: Colors.black87.withOpacity(0.9),
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}
