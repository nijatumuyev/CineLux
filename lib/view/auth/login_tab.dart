import 'package:cinelux/core/components/widgets/button/submit_button.dart';
import 'package:cinelux/core/components/widgets/input/auth_input.dart';
import 'package:cinelux/core/components/widgets/text/locale_text.dart';
import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/language/locale_keys.g.dart';
import 'package:cinelux/core/init/providers/providers.dart';
import 'package:cinelux/core/init/services/auth/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app/app_constants.dart';
import '../../core/init/services/auth/auth_listener.dart';

class LoginTab extends ConsumerStatefulWidget {
  const LoginTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginTabState();
}

class _LoginTabState extends ConsumerState<LoginTab> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constants.instance!.getData(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthInput(
                type: "email",
                controller: emailController,
                autoValidate: false,
                validator: (value) {
                  return null;
                },
                hintText: LocaleKeys.auth_emailHint.locale()),
            15.verticalSpace,
            AuthInput(
                type: "password",
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  return null;
                },
                hintText: LocaleKeys.auth_passwordHint.locale()),
            9.verticalSpace,
            Center(
              child: Text(
                ref.watch(authErrorProvider),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
            9.verticalSpace,
            SubmitButton(
              onTap: () async {
                await ref
                    .read(userServiceProvider.notifier)
                    .signInWithEmailAndPassword(
                        ref: ref,
                        context: context,
                        email: emailController.text,
                        password: passwordController.text);

                debugPrint("*" * 10);
                debugPrint("Button tapped");
                debugPrint("*" * 10);

                if (ref.watch(signInSuccessProvider)) {
                  Get.off(const AuthListener());
                }
              },
              color: Theme.of(context).colorScheme.primary,
              child: LocaleText(
                  text: LocaleKeys.auth_continueButton,
                  style: Constants.myTextTheme!.labelMedium!),
            ),
          ],
        ),
        25.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                thickness: 2,
                color: const Color(0xfffe0000),
                endIndent: 10.w,
              ),
            ),
            LocaleText(
              text: LocaleKeys.auth_orText,
              style: Constants.myTextTheme!.bodyMedium,
            ),
            Expanded(
              child: Divider(
                indent: 10.w,
                thickness: 2,
                color: Colors.red,
              ),
            ),
          ],
        ),
        25.verticalSpace,
        Column(
          children: [
            SubmitButton(
              onTap: () async {
                await ref
                    .read(userServiceProvider.notifier)
                    .signInWithGoogle(context: context);
              },
              color: Colors.transparent,
              horizontalPadding: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/social/g-logo.svg",
                    width: 25,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  10.horizontalSpace,
                  LocaleText(
                    text: LocaleKeys.auth_continueWithG,
                    style: Constants.myTextTheme!.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
