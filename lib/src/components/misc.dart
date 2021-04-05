import 'dart:io';

import 'package:flutter/foundation.dart';

bool get isCupertino {
  if (debugDefaultTargetPlatformOverride != null) {
    return debugDefaultTargetPlatformOverride == TargetPlatform.iOS ||
        debugDefaultTargetPlatformOverride == TargetPlatform.macOS;
  }
  return Platform.isIOS || Platform.isMacOS;
}
