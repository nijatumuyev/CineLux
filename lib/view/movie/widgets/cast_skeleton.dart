import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CastSkeletonWidget extends StatelessWidget {
  const CastSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade700,
            highlightColor: Colors.grey.shade500,
            enabled: true,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 140.w,
                  height: 150.h,
                  padding: EdgeInsets.all(3.r),
                  decoration: BoxDecoration(color: Colors.grey.shade600),
                ),
                5.verticalSpace,
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 140.w,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey.shade600,
                  ),
                ),
                5.verticalSpace,
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 140.w,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
