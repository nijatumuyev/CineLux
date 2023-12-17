import 'package:cached_network_image/cached_network_image.dart';
import 'package:awesome_rating/awesome_rating.dart';
import 'package:cinelux/core/components/widgets/bottom_bar/bottom_nav_bar.dart';
import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/language/locale_keys.g.dart';
import 'package:cinelux/core/init/model/movie_model.dart';
import 'package:cinelux/core/init/providers/movie/helpers/go_to_genre.dart';
import 'package:cinelux/core/init/providers/movie/watch_later/watch_later_notifier.dart';
import 'package:cinelux/view/movie/widgets/cast_widget.dart';
import 'package:cinelux/view/player/yt_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/init/providers/movie/like/liked_movies_notifier.dart';

class MovieScreen extends ConsumerStatefulWidget {
  final String? videoId;
  final Movie movie;

  const MovieScreen({required this.movie, required this.videoId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 32, 43),
      extendBodyBehindAppBar: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              width: double.infinity,
              height: 300.h,
              foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color.fromARGB(255, 12, 32, 43)],
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        CachedNetworkImageProvider(widget.movie.backdropPath!)),
              ),
            ),
            widget.videoId!.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      Get.to(
                        YTPlayer(
                          movie: widget.movie,
                          controller: YoutubePlayerController(
                            flags: const YoutubePlayerFlags(
                              hideThumbnail: false,
                              autoPlay: true,
                              enableCaption: false,
                            ),
                            initialVideoId: widget.videoId!,
                          ),
                        ),
                      );
                    },
                    iconSize: 85.sp,
                    color: Colors.red.shade800,
                    icon: const Icon(
                      Icons.play_circle_outline_sharp,
                    ),
                  )
                : const SizedBox(),
            Positioned(
              bottom: 0.h,
              left: 10.w,
              right: 10.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title!,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  3.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    height: 25,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AwesomeStarRating(
                          allowHalfRating: true,
                          borderColor: Colors.grey.shade400,
                          size: 20.sp,
                          starCount: 5,
                          spacing: 2.w,
                          color: Colors.red,
                          rating: widget.movie.voteAverage! / 2,
                        ),
                        10.horizontalSpace,
                        Text(
                          widget.movie.voteAverage.toString(),
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade300),
                        ),
                        5.horizontalSpace,
                        VerticalDivider(
                          thickness: 1,
                          color: Colors.grey.shade500,
                        ),
                        Icon(
                          Icons.calendar_month,
                          size: 20.sp,
                          color: Colors.red,
                        ),
                        5.horizontalSpace,
                        Text(
                          widget.movie.releaseDate!.split("-")[0],
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade300),
                        ),
                        5.horizontalSpace,
                        VerticalDivider(
                          thickness: 1,
                          color: Colors.grey.shade500,
                        ),
                        Icon(
                          Icons.play_circle_outline_sharp,
                          size: 20.sp,
                          color: Colors.red,
                        ),
                        5.horizontalSpace,
                        Text(
                          (widget.movie.voteCount! + 15368).toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30.h,
              left: 5.w,
              child: Container(
                  padding: EdgeInsets.only(left: 4.w),
                  alignment: Alignment.center,
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      tileMode: TileMode.clamp,
                      radius: 0.5.r,
                      colors: [
                        const Color(0xff1d1d27).withOpacity(0.5.r),
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: BackButton(
                    style: ButtonStyle(
                      iconSize: MaterialStatePropertyAll(25.sp),
                    ),
                    color: Colors.white,
                  )),
            ),
          ]),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      width: double.infinity,
                      child: widget.movie.genres.isNotEmpty
                          ? CustomRadioButton(
                              buttonLables: widget.movie.genres,
                              buttonValues: widget.movie.genres,
                              radioButtonValue: (value, index) {
                                goToGenre(widget.movie.genres[index], ref);
                              },
                              horizontal: true,
                              elevation: 5.r,
                              lineSpace: 0,
                              fontSize: 14.sp,
                              enableShape: true,
                              customShape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(5.r)),
                              unselectedButtonBorderColor: Colors.grey.shade500,
                              textColor: Colors.grey.shade400,
                              selectedTextColor: Colors.grey.shade400,
                              buttonSpace: 5.w,
                              buttonColor: Colors.transparent,
                              selectedColor: Colors.transparent,
                              buttonBorderColor: Colors.grey.shade500,
                            )
                          : null,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    widget.movie.overview!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              5.verticalSpace,
                              Text(
                                LocaleKeys.movieScreen_storyLine.locale(),
                                style: TextStyle(
                                    color: Colors.grey.shade300,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w300),
                              ),
                              5.verticalSpace,
                              Text(
                                widget.movie.overview!,
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          )
                        : const SizedBox(),
                    20.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 85.w,
                            height: 50.h,
                            child: InkWell(
                              onTap: () async {
                                await ref
                                    .read(likeMovieServiceProvider.notifier)
                                    .likeMovie(widget.movie);
                              },
                              child: ref.watch(likeMovieStreamProvider).when(
                                error: (error, tree) {
                                  return const SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                                loading: () {
                                  return const SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                                data: (data) {
                                  bool? isLiked = data.docs.any((e) =>
                                      e.id == widget.movie.id.toString());
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isLiked
                                            ? Colors.red
                                            : Colors.grey.shade400,
                                        size: 30.sp,
                                      ),
                                      Text(
                                        LocaleKeys.movieScreen_like.locale(),
                                        style: TextStyle(
                                            color: isLiked
                                                ? Colors.red
                                                : Colors.grey.shade400,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            thickness: 2,
                          ),
                          SizedBox(
                              width: 120.w,
                              height: 50.h,
                              child: InkWell(
                                onTap: () {
                                  ref
                                      .read(watchLaterServiceProvider.notifier)
                                      .addToWatchLater(widget.movie);
                                },
                                child: ref.watch(watchLaterStreamProvider).when(
                                  error: (error, tree) {
                                    return const SizedBox(
                                      width: 45,
                                      height: 45,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  },
                                  loading: () {
                                    return const SizedBox(
                                      width: 45,
                                      height: 45,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  },
                                  data: (data) {
                                    bool? isIntoList = data.docs.any((e) =>
                                        e.id == widget.movie.id.toString());
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          isIntoList
                                              ? Icons.video_library
                                              : Icons.video_library_outlined,
                                          color: isIntoList
                                              ? Colors.red
                                              : Colors.grey.shade500,
                                          size: 30.sp,
                                        ),
                                        Text(
                                          LocaleKeys.movieScreen_addToList
                                              .locale(),
                                          style: TextStyle(
                                              color: isIntoList
                                                  ? Colors.red
                                                  : Colors.grey.shade400,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              )),
                          const VerticalDivider(
                            thickness: 2,
                          ),
                          SizedBox(
                            width: 85.w,
                            height: 50.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  color: Colors.grey.shade500,
                                  size: 30.sp,
                                ),
                                Text(
                                  LocaleKeys.movieScreen_share.locale(),
                                  style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,

                    CastWidget(movieId: widget.movie.id),
                    20.verticalSpace,
                    // SimilarWidget(
                    //   genre: movie.genres[0],
                    //   thisMovieId: movie.id,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
