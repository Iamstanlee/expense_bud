import 'package:flutter/foundation.dart';

void safePrint(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}
