import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class LocaleText extends StatelessWidget {
  final String? text;
  final int maxLines;
  final TextStyle? style;

  const LocaleText({
    super.key,
    required this.text,
    required this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!.locale(),
      maxLines: maxLines,
      style: style,
    );
  }
}
