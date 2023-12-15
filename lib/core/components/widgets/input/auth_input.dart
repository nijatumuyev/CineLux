import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthInput extends ConsumerWidget {
  final double contentPadding;
  final String? type;
  final int maxLines;
  final int maxLength;
  final bool autoValidate;
  final double borderRadius;
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final String? hintText;
  final bool obscureText;
  final StateProvider<bool> passwordObscureProvider =
      StateProvider<bool>((ref) => true);

  AuthInput(
      {super.key,
      this.contentPadding = 20,
      this.maxLines = 1,
      this.maxLength = 30,
      this.autoValidate = false,
      this.obscureText = false,
      this.borderRadius = 5,
      required this.type,
      required this.controller,
      required this.validator,
      required this.hintText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      maxLines: maxLines,
      cursorColor: Colors.white,
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
      controller: controller,
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      validator: autoValidate ? validator : (value) => null,
      obscureText: obscureText ? ref.watch(passwordObscureProvider) : false,
      obscuringCharacter: "●",
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(contentPadding.r),
        filled: true,
        fillColor: Colors.black26,
        prefixIconColor: Colors.grey.shade500,
        suffixIconColor: Colors.grey.shade500,
        hintText: hintText,
        hintStyle: const TextStyle(),
        errorMaxLines: 2,
        errorStyle: TextStyle(
            color: const Color(0xfffe0000),
            fontWeight: FontWeight.w500,
            fontSize: 13.sp),
        prefixIcon: type == "email"
            ? const Icon(Icons.email)
            : type == "password"
                ? const Icon(Icons.lock)
                : type == "name"
                    ? const Icon(Icons.person)
                    : type == "bio"
                        ? const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 63),
                            child: Icon(Icons.description),
                          )
                        : const Icon(Icons.manage_search),
        suffixIcon: obscureText
            ? IconButton(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  ref
                      .read(passwordObscureProvider.notifier)
                      .update((state) => !state);
                },
                icon: Icon(ref.watch(passwordObscureProvider)
                    ? Icons.visibility
                    : Icons.visibility_off),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey.shade600,
              style: BorderStyle.solid,
              width: 1.w),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey.shade500,
              style: BorderStyle.solid,
              width: 1.5.w),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color(0xfffe0000),
              style: BorderStyle.solid,
              width: 1.w),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color(0xfffe0000),
              style: BorderStyle.solid,
              width: 1.5.w),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
    );
  }
}
