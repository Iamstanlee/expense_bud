import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtils {
  static bool get isIOS {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isIOS;
    }
  }

  static bool get isAndroid {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isAndroid;
    }
  }
}
