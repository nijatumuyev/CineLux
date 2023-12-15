import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app/app_constants.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final double height;
  final Widget child;
  final Alignment alignment;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final Color? color;

  const SubmitButton({
    super.key,
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 5,
    this.alignment = Alignment.center,
    this.color,
    this.horizontalPadding = 0,
    this.verticalPadding = 10,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        width: width.w,
        height: height.h,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding.w, vertical: verticalPadding.h),
        alignment: alignment,
        decoration: BoxDecoration(
          color: color ?? Constants.myColorScheme!.primary,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(
              width: 1.5.w,
              color: color == Colors.transparent
                  ? Colors.grey.shade700
                  : Colors.transparent),
        ),
        child: child,
      ),
    );
  }
}
