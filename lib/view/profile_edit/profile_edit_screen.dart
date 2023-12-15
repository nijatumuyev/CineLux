import 'package:cinelux/core/components/widgets/bottom_bar/bottom_nav_bar.dart';
import 'package:cinelux/core/components/widgets/input/auth_input.dart';
import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/providers/providers.dart';
import 'package:cinelux/view/profile/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../../core/init/model/user_model.dart';
import '../../core/init/services/auth/user_service.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _bioController = TextEditingController();

class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userStream = ref.watch(userStreamProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 32, 43),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 32, 48),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          LocaleKeys.editProfile_settings.locale(),
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19.sp),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(userServiceProvider.notifier).updateProfile(
                  ref: ref,
                  name: _nameController.text,
                  bio: _bioController.text,
                  email: _emailController.text,
                  context: context);
              Get.back();
            },
            child: Text(
              LocaleKeys.editProfile_save.locale(),
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: const Color(0xfffe0000)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<UserModel>(
          initialData: ref.watch(userServiceProvider),
          future: ref.read(userServiceProvider.notifier).getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final UserModel user = snapshot.data!;
              _nameController.text = user.displayName!;
              _emailController.text = user.email!;
              _bioController.text = user.bio!;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    Center(
                      child: ProfileImage(
                        isEditing: true,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      LocaleKeys.auth_nameHint.locale(),
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    5.verticalSpace,
                    AuthInput(
                        type: "name",
                        controller: _nameController,
                        validator: (value) => null,
                        hintText: user.displayName),
                    30.verticalSpace,
                    Text(
                      LocaleKeys.auth_emailHint.locale(),
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    5.verticalSpace,
                    AuthInput(
                        type: "email",
                        autoValidate: true,
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isValidEmail()) {
                            return null;
                          } else if (value.isEmpty) {
                            return LocaleKeys.validators_emailEmpty.locale();
                          } else {
                            return LocaleKeys.validators_emailWrong.locale();
                          }
                        },
                        hintText: user.email),
                    7.verticalSpace,
                    Text(
                      ref.watch(authErrorProvider),
                      style: TextStyle(color: Colors.red, fontSize: 15.sp),
                    ),
                    20.verticalSpace,
                    Text(
                      LocaleKeys.auth_bioHint.locale(),
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    5.verticalSpace,
                    AuthInput(
                        type: "bio",
                        controller: _bioController,
                        maxLength: 120,
                        maxLines: 4,
                        validator: (value) {
                          if (value!.length >= 120) {
                            return LocaleKeys.auth_bioMax.locale();
                          } else {
                            return " ";
                          }
                        },
                        hintText: user.bio),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
