import 'package:cinelux/core/init/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/init/services/auth/user_service.dart';
import 'profile_image.dart';

class AboutWidget extends ConsumerWidget {
  const AboutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<UserModel>(
      initialData: ref.watch(userServiceProvider),
      future: ref.read(userServiceProvider.notifier).getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final UserModel user = snapshot.data!;
          return Container(
            width: double.infinity,
            height: 140.h,
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff2A2E3C), Color.fromARGB(255, 12, 32, 43)]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileImage(
                  isEditing: false,
                ),
                20.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      15.verticalSpace,
                      Text(
                        user.displayName!,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        user.email!,
                        style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400),
                      ),
                      10.verticalSpace,
                      Text(
                        user.bio!,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            width: double.infinity,
            height: 140.h,
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff2A2E3C), Color.fromARGB(255, 12, 32, 43)]),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: const Color(0xfffe0000),
              ),
            ),
          );
        }
      },
    );
  }
}
