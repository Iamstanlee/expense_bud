import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Gap extends LeafRenderObjectWidget {
  const Gap(this.gap, {Key? key}) : super(key: key);
  final double gap;

  static const sm = Gap(8);
  static const md = Gap(16);
  static const lg = Gap(32);

  @override
  RenderObject createRenderObject(BuildContext context) => RenderGap(gap: gap);

  @override
  void updateRenderObject(
          BuildContext context, covariant RenderGap renderObject) =>
      renderObject.gap = gap;
}

class RenderGap extends RenderBox {
  RenderGap({required double gap}) : _gap = gap;

  double get gap => _gap;
  double _gap;

  set gap(double gap) {
    if (gap == _gap) {
      return;
    }
    _gap = gap;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final Axis? direction = (parent as RenderFlex?)?.direction;
    assert(direction != null,
        'gap should not be used outside of a Flex (Row, Column)');
    if (direction == null) {
      size = Size(0, gap);
    } else {
      size = Size(direction == Axis.horizontal ? gap : 0,
          direction == Axis.vertical ? gap : 0);
    }
  }
}
