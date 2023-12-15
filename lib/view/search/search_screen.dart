import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinelux/core/components/widgets/bottom_bar/bottom_nav_bar.dart';
import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../core/init/api/search/search_api.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../../core/init/model/movie_model.dart';
import '../movie/movie_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    late Movie? movie;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 32, 43),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 45.h,
                child: TypeAheadField<Movie?>(
                  textFieldConfiguration: TextFieldConfiguration(
                    cursorColor: Colors.white,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(7.r),
                      filled: true,
                      fillColor: Colors.black26,
                      hintText: LocaleKeys.homeScreen_search.locale(),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.shade600,
                            style: BorderStyle.solid,
                            width: 1.w),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            style: BorderStyle.solid,
                            width: 1.5.w),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xfffe0000),
                            style: BorderStyle.solid,
                            width: 1.w),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xfffe0000),
                            style: BorderStyle.solid,
                            width: 1.5.w),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ),
                  debounceDuration: const Duration(milliseconds: 500),
                  hideSuggestionsOnKeyboardHide: false,
                  hideKeyboardOnDrag: true,
                  minCharsForSuggestions: 1,
                  onSuggestionsBoxToggle: (p0) {
                    p0 = false;
                  },
                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      color: Colors.transparent,
                      constraints: BoxConstraints(
                        maxHeight: 0.795.sh,
                        minHeight: 0.sh,
                      )),
                  itemSeparatorBuilder: (context, index) {
                    if (movie!.voteAverage == 0 ||
                        movie!.backdropPath ==
                            "https://image.tmdb.org/t/p/original/null") {
                      return const SizedBox();
                    } else {
                      return const Divider(
                        thickness: 2,
                      );
                    }
                  },
                  suggestionsCallback: (pattern) async {
                    return await searchMovie(pattern);
                  },
                  itemBuilder: (context, Movie? suggestion) {
                    movie = suggestion!;
                    if (movie!.voteAverage == 0 ||
                        movie!.backdropPath ==
                            "https://image.tmdb.org/t/p/original/null") {
                      return const SizedBox();
                    } else {
                      return Container(
                          width: double.infinity,
                          height: 120.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2.r),
                                width: 85.w,
                                height: 110.h,
                                color: Colors.grey.shade600,
                                child: CachedNetworkImage(
                                  imageUrl: movie!.posterPath!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              8.horizontalSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie!.title!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    3.5.verticalSpace,
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.play_circle,
                                          color: const Color(0xfffe0000),
                                          size: 15.sp,
                                        ),
                                        7.horizontalSpace,
                                        Text(
                                          movie!.voteCount!.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    3.5.verticalSpace,
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: const Color(0xfffe0000),
                                          size: 15.sp,
                                        ),
                                        7.horizontalSpace,
                                        Text(
                                          movie!.releaseDate!.split("-")[0],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    3.5.verticalSpace,
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: const Color(0xfffe0000),
                                          size: 15.sp,
                                        ),
                                        7.horizontalSpace,
                                        Text(
                                          movie!.voteAverage!.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    3.5.verticalSpace,
                                    Text(
                                      movie!.genreView,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: const Color(0xfffe0000),
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ));
                    }
                  },
                  noItemsFoundBuilder: (context) {
                    return Center(
                      child: Text(
                        LocaleKeys.homeScreen_notFound.locale(),
                        style: const TextStyle(
                            color: Color(0xfffe0000),
                            fontWeight: FontWeight.w400),
                      ),
                    );
                  },
                  onSuggestionSelected: (Movie? suggestion) async {
                    final movie = suggestion!;
                    final String videoId = await movie.getVideoId(movie.id!);
                    Get.to(
                      MovieScreen(
                        movie: movie,
                        videoId: videoId,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
