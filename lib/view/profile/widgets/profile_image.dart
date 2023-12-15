import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/init/model/user_model.dart';
import '../../../core/init/services/auth/user_service.dart';

class ProfileImage extends ConsumerWidget {
  final bool isEditing;
  final double height;
  final double width;
  final StateProvider<bool> uploadPictureProvider =
      StateProvider<bool>((ref) => false);

  ProfileImage({
    super.key,
    this.isEditing = true,
    this.height = 130,
    this.width = 130,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isUploadingImage = ref.watch(uploadPictureProvider);

    return FutureBuilder<UserModel>(
      initialData: ref.watch(userServiceProvider),
      future: ref.read(userServiceProvider.notifier).getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final UserModel user = snapshot.data!;
          return Container(
            width: width.w,
            height: height.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.shade900,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade600, width: 3.w)),
            child: isUploadingImage
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            user.photoUrl!,
                          ),
                        ),
                      ),
                      isEditing
                          ? Positioned(
                              bottom: 10.r,
                              right: -0.r,
                              child: InkWell(
                                onTap: () async {
                                  await ref
                                      .read(userServiceProvider.notifier)
                                      .uploadImage(ref, uploadPictureProvider);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 12, 32, 43),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.grey.shade600,
                                              width: 3.w)),
                                    ),
                                    Icon(
                                      Icons.change_circle_outlined,
                                      size: 30.sp,
                                      color: const Color(0xfffe0000),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
          );
        } else {
          return const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: Color(0xfffe0000),
              ),
            ),
          );
        }
      },
    );
  }
}
