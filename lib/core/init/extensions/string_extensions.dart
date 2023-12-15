import 'package:cinelux/core/constants/app/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';

extension StringLocalization on String {
  String locale() => this.tr();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return Constants.emailValidator.hasMatch(this);
  }
}
