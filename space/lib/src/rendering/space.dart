// ------------------------------------------------------------ //
//  space.dart
//
//  Created by Siva Sankar on 2025-09-19.
// ------------------------------------------------------------ //


import 'package:flutter/rendering.dart';

class RenderSpace extends RenderBox {
  RenderSpace({
    required double mainAxisExtent,
    double? crossAxisExtent,
    Axis? fallbackDirection,
    Color? color,
  })  : _mainAxisExtent = mainAxisExtent,
        _crossAxisExtent = crossAxisExtent,
        _fallbackDirection = fallbackDirection,
        _color = color;

  double _mainAxisExtent;
  double? _crossAxisExtent;
  Axis? _fallbackDirection;
  Color? _color;

  double get mainAxisExtent => _mainAxisExtent;
  set mainAxisExtent(double value) {
    if (_mainAxisExtent != value) {
      _mainAxisExtent = value;
      markNeedsLayout();
    }
  }

  double? get crossAxisExtent => _crossAxisExtent;
  set crossAxisExtent(double? value) {
    if (_crossAxisExtent != value) {
      _crossAxisExtent = value;
      markNeedsLayout();
    }
  }

  Axis? get fallbackDirection => _fallbackDirection;
  set fallbackDirection(Axis? value) {
    if (_fallbackDirection != value) {
      _fallbackDirection = value;
      markNeedsLayout();
    }
  }

  Color? get color => _color;
  set color(Color? value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  Axis? get _direction {
    final parentNode = parent;
    if (parentNode is RenderFlex) return parentNode.direction;
    return fallbackDirection;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final dir = _direction;
    if (dir == null) {
      throw FlutterError('Space must be inside a Flex or provide fallbackDirection.');
    }

    if (dir == Axis.horizontal) {
      return constraints.constrain(Size(mainAxisExtent, crossAxisExtent ?? 0));
    } else {
      return constraints.constrain(Size(crossAxisExtent ?? 0, mainAxisExtent));
    }
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (color != null) {
      final paint = Paint()..color = color!;
      context.canvas.drawRect(offset & size, paint);
    }
  }
}