// ------------------------------------------------------------
// sliver_space.dart
//
// Created by Siva Sankar on 2025-09-19.
// ------------------------------------------------------------

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_space/src/constants/spacing.dart';
import 'package:flutter_space/src/rendering/sliver_space.dart';

/// A sliver widget that creates space in a scrollable area.
class SliverSpace extends LeafRenderObjectWidget {
  const SliverSpace(this.extent, {super.key, this.color});

  const SliverSpace.size(Spacing size, {super.key, this.color}) : extent = size;

  const SliverSpace.tiny({super.key, this.color}) : extent = Spacing.tiny;
  const SliverSpace.extraSmall({super.key, this.color})
    : extent = Spacing.extraSmall;
  const SliverSpace.small({super.key, this.color}) : extent = Spacing.small;
  const SliverSpace.medium({super.key, this.color}) : extent = Spacing.medium;
  const SliverSpace.large({super.key, this.color}) : extent = Spacing.large;
  const SliverSpace.extraLarge({super.key, this.color})
    : extent = Spacing.extraLarge;
  const SliverSpace.huge({super.key, this.color}) : extent = Spacing.huge;
  const SliverSpace.massive({super.key, this.color}) : extent = Spacing.massive;
  const SliverSpace.zero({super.key, this.color}) : extent = 0;

  /// The extent along the main axis.
  /// Can be either a [num] (int/double) or [Spacing] enum.
  final Object extent;

  /// Optional color for debugging or visual purposes.
  final Color? color;

  /// Effective main axis extent in pixels.
  double get _effectiveMainAxisExtent {
    if (extent is num) return (extent as num).toDouble();
    if (extent is Spacing) return (extent as Spacing).value;
    return 0.0;
  }

  bool get hasExtent => _effectiveMainAxisExtent > 0;
  Spacing? get spacingType => extent is Spacing ? extent as Spacing : null;
  double? get numericExtent =>
      extent is num ? (extent as num).toDouble() : null;

  @override
  RenderSliverSpace createRenderObject(BuildContext context) {
    assert(
      extent is num || extent is Spacing,
      'extent must be either a num (int/double) or Spacing enum. Got: ${extent.runtimeType}',
    );

    if (extent is num) {
      final val = (extent as num).toDouble();
      assert(val >= 0, 'numeric extent must be non-negative. Got: $extent');
    }

    final effectiveExtent = _effectiveMainAxisExtent;
    return RenderSliverSpace(
      mainAxisExtent: effectiveExtent,
      color: color,
      maxExtent: effectiveExtent,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderSliverSpace renderObject,
  ) {
    final effectiveExtent = _effectiveMainAxisExtent;
    renderObject
      ..mainAxisExtent = effectiveExtent
      ..color = color;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    if (extent is num) {
      properties.add(DoubleProperty('extent', (extent as num).toDouble()));
    } else if (extent is Spacing) {
      properties.add(EnumProperty<Spacing>('extent', extent as Spacing));
    } else {
      properties.add(DiagnosticsProperty<Object>('extent', extent));
    }

    properties.add(DoubleProperty('effectiveExtent', _effectiveMainAxisExtent));
    properties.add(ColorProperty('color', color));
    properties.add(
      FlagProperty('hasExtent', value: hasExtent, ifFalse: 'zero extent'),
    );
  }
}

/// A sliver that creates flexible space in a scrollable area.
/// Currently uses minExtent as fixed space.
class SliverFlexibleSpace extends LeafRenderObjectWidget {
  const SliverFlexibleSpace({
    super.key,
    this.minExtent = 0,
    this.maxExtent = double.infinity,
    this.color,
  }) : assert(minExtent >= 0, 'minExtent must be non-negative'),
       assert(maxExtent >= minExtent, 'maxExtent must be >= minExtent');

  final double minExtent;
  final double maxExtent;
  final Color? color;

  @override
  RenderSliverSpace createRenderObject(BuildContext context) {
    return RenderSliverSpace(
      mainAxisExtent: minExtent,
      color: color,
      maxExtent: minExtent,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderSliverSpace renderObject,
  ) {
    renderObject
      ..mainAxisExtent = minExtent
      ..color = color;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('minExtent', minExtent));
    properties.add(DoubleProperty('maxExtent', maxExtent));
    properties.add(ColorProperty('color', color));
  }
}
