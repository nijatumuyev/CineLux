import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/components/widgets/button/submit_button.dart';
import '../../core/components/widgets/input/auth_input.dart';
import '../../core/components/widgets/text/locale_text.dart';
import '../../core/constants/app/app_constants.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../../core/init/providers/providers.dart';
import '../../core/init/services/auth/auth_listener.dart';
import '../../core/init/services/auth/user_service.dart';

class RegisterTab extends ConsumerStatefulWidget {
  const RegisterTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterTabState();
}

class _RegisterTabState extends ConsumerState<RegisterTab> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constants.instance!.getData(context);
    final userService = ref.read(userServiceProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthInput(
                type: "name",
                controller: nameController,
                autoValidate: true,
                validator: (value) {
                  if (value!.startsWith(" ")) {
                    return LocaleKeys.validators_nameSpace.locale();
                  } else if (value.trim().isEmpty) {
                    return LocaleKeys.validators_nameEmpty.locale();
                  } else {
                    return null;
                  }
                },
                hintText: LocaleKeys.auth_nameHint.locale()),
            10.verticalSpace,
            AuthInput(
                type: "email",
                controller: emailController,
                autoValidate: true,
                validator: (value) {
                  if (value!.isValidEmail()) {
                    return null;
                  } else if (value.isEmpty) {
                    return LocaleKeys.validators_emailEmpty.locale();
                  } else {
                    return LocaleKeys.validators_emailWrong.locale();
                  }
                },
                hintText: LocaleKeys.auth_emailHint.locale()),
            10.verticalSpace,
            AuthInput(
                type: "password",
                controller: passwordController,
                obscureText: true,
                autoValidate: true,
                validator: (value) {
                  if (value!.contains(" ")) {
                    return LocaleKeys.validators_passSpace.locale();
                  } else if (value.isEmpty) {
                    return LocaleKeys.validators_passEmpty.locale();
                  } else if (value.length < 6) {
                    return LocaleKeys.validators_passWrong.locale();
                  } else {
                    return null;
                  }
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
                await userService.signUpWithEmailPassword(
                    ref: ref,
                    context: context,
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text);

                if (ref.watch(signUpSuccessProvider)) {
                  Get.off(const AuthListener());
                }
              },
              color: Theme.of(context).colorScheme.primary,
              child: LocaleText(
                text: LocaleKeys.auth_continueButton,
                style: Constants.myTextTheme!.labelMedium,
              ),
            ),
          ],
        ),
        20.verticalSpace,
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
                color: const Color(0xfffe0000),
              ),
            ),
          ],
        ),
        20.verticalSpace,
        Column(
          children: [
            SubmitButton(
              onTap: () async {
                await userService.signInWithGoogle(context: context);
                debugPrint("*" * 10);
                debugPrint("Button tapped");
                debugPrint("*" * 10);
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
