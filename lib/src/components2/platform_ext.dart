import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

extension PlatformExt on Platform {
  static String get languageCode {
    final locale = Intl.getCurrentLocale();
    var index = locale.indexOf('-');
    if (index == -1) {
      index = locale.indexOf('_');
    }
    return index == -1 ? locale : locale.substring(0, index);
  }

  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  static bool get isIOS => !kIsWeb && Platform.isIOS;

  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
}
