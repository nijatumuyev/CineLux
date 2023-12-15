import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SimilarSkeleton extends StatelessWidget {
  const SimilarSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade500,
                  enabled: true,
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Text(
                      "Popular",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.transparent,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade700,
              highlightColor: Colors.grey.shade500,
              enabled: true,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.grid_view_rounded,
                  color: Colors.grey.shade200,
                ),
                iconSize: 30.sp,
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade500,
                      enabled: true,
                      child: Container(
                        width: 120.w,
                        height: 150.h,
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(color: Colors.grey.shade600),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade500,
                      enabled: true,
                      child: Container(
                        margin: EdgeInsets.only(right: 4.w, top: 4.h),
                        width: 105.w,
                        height: 6.h,
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(10.r),
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
  }
}
