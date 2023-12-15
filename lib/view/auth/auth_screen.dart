// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cinelux/view/auth/register_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/components/widgets/text/locale_text.dart';
import '../../core/constants/app/app_constants.dart';
import '../../core/init/language/locale_keys.g.dart';
import 'login_tab.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Constants.instance!.getData(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 12, 32, 43),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 0.h,
            left: 20.w,
            right: 20.w,
          ),
          child: DefaultTabController(
            length: 2,
            initialIndex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                20.verticalSpace,
                SvgPicture.asset(
                  "assets/logo/cinelux-logo-text-only.svg",
                  width: 0.7.sw,
                ),
                20.verticalSpace,
                TabBar(
                    indicatorColor: const Color(0xfffe0000),
                    dividerColor: const Color(0xfffe0000),
                    tabs: [
                      Tab(
                        child: LocaleText(
                          text: LocaleKeys.auth_logIn,
                          maxLines: 1,
                          style: Constants.myTextTheme!.labelMedium,
                        ),
                      ),
                      Tab(
                        child: LocaleText(
                          text: LocaleKeys.auth_register,
                          maxLines: 1,
                          style: Constants.myTextTheme!.labelMedium,
                        ),
                      ),
                    ]),
                15.verticalSpace,
                Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        //Log in Tab
                        SingleChildScrollView(child: LoginTab()),
                        //Sign in Tab
                        SingleChildScrollView(child: RegisterTab()),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
