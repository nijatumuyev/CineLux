// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/components/widgets/bottom_bar/bottom_nav_bar.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../profile_edit/profile_edit_screen.dart';
import 'widgets/about.dart';
import 'widgets/profile_components.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 32, 43),
      appBar: _AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AboutWidget(),
            ProfileComponents(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 12, 32, 48),
        systemNavigationBarColor: Color.fromARGB(255, 12, 32, 48),
      ),
      backgroundColor: const Color.fromARGB(255, 12, 32, 48),
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Text(
        LocaleKeys.editProfile_account.locale(),
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19.sp),
      ),
      actions: [
        Center(
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Get.to(const ProfileEditScreen());
                },
                child: Text(
                  LocaleKeys.editProfile_edit.locale(),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: const Color(0xfffe0000)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
