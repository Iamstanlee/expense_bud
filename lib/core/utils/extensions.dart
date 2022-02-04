import 'package:expense_tracker/core/utils/router.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  int toInt() => int.parse(this);
  double toFloat() => double.parse(this);
}

extension ContextExtension on BuildContext {
  double getHeight({double factor = 1}) {
    assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth({double factor = 1}) {
    assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();
  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;

  Future<T?> push<T>(Widget page) =>
      Navigator.push<T>(this, PageRouter.fadeThrough(() => page));

  Future<bool> pop<T>([T? result]) => Navigator.maybePop(this, result);
}

extension ClickableExtension on Widget {
  Widget onTap(VoidCallback action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }
}
