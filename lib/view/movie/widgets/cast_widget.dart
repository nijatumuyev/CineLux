import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/model/cast_model.dart';
import 'package:cinelux/core/init/api/cast/cast_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/init/language/locale_keys.g.dart';
import 'cast_skeleton.dart';

class CastWidget extends ConsumerWidget {
  final int? movieId;
  const CastWidget({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = getMovieCast(movieId!);
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Cast> castList = [];
          for (var element in snapshot.data!) {
            if (element.department == "Acting") {
              castList.add(element);
            }
          }
          if (castList.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.movieScreen_cast.locale(),
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w300),
                ),
                10.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  height: 190.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: castList.length,
                    itemBuilder: (context, index) {
                      Cast actor = castList[index];

                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Column(
                          children: [
                            Container(
                              width: 140.w,
                              height: 170.h,
                              padding: EdgeInsets.all(3.r),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade600),
                              child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: actor.profilePath!,
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      "assets/noImage.jpg",
                                      fit: BoxFit.cover,
                                    );
                                  },
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
                                        child: const CircularProgressIndicator(
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            5.verticalSpace,
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              width: 140.w,
                              height: 15.h,
                              child: Text(
                                actor.name!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
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
            return const SizedBox();
          }
        } else {
          return const CastSkeletonWidget();
        }
      },
    );
  }
}
