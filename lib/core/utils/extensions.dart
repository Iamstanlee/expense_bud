import 'package:expense_bud/core/utils/router.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

extension StringExtension on String {
  int toInt() => int.parse(this);
  double toDouble() => double.parse(this);
  DateTime toDateTime() => DateTime.parse(this);

  String pluralize(int len) {
    if (isEmpty) return "";
    if (len == 1) return this;
    if (this[length - 1] == "y") return "${substring(0, length - 1)}ies";
    return "${this}s";
  }

  String titleCaseSingle() {
    if (isEmpty) return "";
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String defaultOnEmpty([String defaultValue = ""]) =>
      isEmpty ? defaultValue : this;

  void launchAsUrl() async {
    try {
      if (await canLaunch(this)) {
        launch(this);
      }
    } catch (e) {
      return;
    }
  }
}

extension NumberExtension on num {
  /// interpolate a value from one range to another
  double normalize(
    num min,
    num max, {
    lowerBound = 0,
    upperBound = 100,
  }) {
    if (this == 0) return 0;
    return (upperBound - lowerBound) * ((this - min) / (max - min)) +
        lowerBound;
  }
}

extension IterableExtension on Iterable<int> {
  int getMax() => reduce(math.max);
  int getMin() => reduce(math.min);
}

extension ContextExtension on BuildContext {
  double getHeight([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();
  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;

  Future<T?> push<T>(Widget page) =>
      Navigator.push<T>(this, PageRouter.fadeThrough(() => page));

  Future<T?> pushOff<T>(Widget page) => Navigator.pushAndRemoveUntil<T>(
      this, PageRouter.fadeThrough(() => page), (_) => false);

  Future<bool> pop<T>([T? result]) => Navigator.maybePop(this, result);
}

extension WidgetExtension on Widget {
  Widget onTap(VoidCallback action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }
}
