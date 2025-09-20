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
///
/// This widget is designed to be used within slivers like [CustomScrollView],
/// [NestedScrollView], or other sliver-based scrollable widgets. It creates
/// empty space that scrolls with the content.
///
/// Supports both explicit numeric spacing and enum-based predefined spacing.
///
/// Example usage:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SliverAppBar(title: Text('Header')),
///     SliverSpace(20), // 20 pixels of space
///     SliverSpace(Spacing.large), // Large predefined spacing
///     SliverSpace.large(), // Alternative syntax for large spacing
///     SliverList(...),
///   ],
/// )
/// ```
class SliverSpace extends LeafRenderObjectWidget {
  /// Creates a sliver with either explicit numeric extent or enum-based spacing.
  ///
  /// The [extent] parameter can be either:
  /// - A [double] for explicit pixel spacing (e.g., `SliverSpace(20)`)
  /// - A [Spacing] enum for predefined spacing (e.g., `SliverSpace(Spacing.large)`)
  const SliverSpace(this.extent, {super.key, this.color});

  /// Creates a sliver with predefined enum-based spacing.
  ///
  /// This is an alternative constructor that's more explicit about using enums.
  const SliverSpace.size(Spacing size, {super.key, this.color}) : extent = size;

  /// Creates a tiny sliver space using predefined spacing.
  const SliverSpace.tiny({super.key, this.color}) : extent = Spacing.tiny;

  /// Creates an extra small sliver space using predefined spacing.
  const SliverSpace.extraSmall({super.key, this.color})
    : extent = Spacing.extraSmall;

  /// Creates a small sliver space using predefined spacing.
  const SliverSpace.small({super.key, this.color}) : extent = Spacing.small;

  /// Creates a medium sliver space using predefined spacing.
  const SliverSpace.medium({super.key, this.color}) : extent = Spacing.medium;

  /// Creates a large sliver space using predefined spacing.
  const SliverSpace.large({super.key, this.color}) : extent = Spacing.large;

  /// Creates an extra large sliver space using predefined spacing.
  const SliverSpace.extraLarge({super.key, this.color})
    : extent = Spacing.extraLarge;

  /// Creates a huge sliver space using predefined spacing.
  const SliverSpace.huge({super.key, this.color}) : extent = Spacing.huge;

  /// Creates a massive sliver space using predefined spacing.
  const SliverSpace.massive({super.key, this.color}) : extent = Spacing.massive;

  /// Creates a zero-height sliver space.
  ///
  /// Useful as a placeholder or for conditional spacing.
  const SliverSpace.zero({super.key, this.color}) : extent = 0;

  /// The extent along the main (scroll) axis.
  /// Can be either a [double] (pixels) or [Spacing] enum.
  final Object extent;

  /// Optional color for debugging or visual purposes.
  ///
  /// When provided, the space will be filled with this color, making it
  /// visible. Useful for debugging layout issues or creating colored
  /// separators in slivers.
  final Color? color;

  /// Gets the effective main axis extent in pixels.
  double get _effectiveMainAxisExtent {
    if (extent is double) {
      return extent as double;
    } else if (extent is Spacing) {
      return (extent as Spacing).value;
    }
    return 0;
  }

  /// Whether this sliver space has any actual extent.
  bool get hasExtent => _effectiveMainAxisExtent > 0;

  /// Returns the spacing type if using enum, null if using numeric value.
  Spacing? get spacingType => extent is Spacing ? extent as Spacing : null;

  /// Returns the numeric value if using explicit pixels, null if using enum.
  double? get numericExtent => extent is double ? extent as double : null;

  @override
  RenderSliverSpace createRenderObject(BuildContext context) {
    // Validate the extent parameter
    assert(
      extent is double || extent is Spacing,
      'extent must be either a double or Spacing enum. Got: ${extent.runtimeType}',
    );

    if (extent is double) {
      assert(
        (extent as double) >= 0,
        'numeric extent must be non-negative. Got: $extent',
      );
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

    if (extent is double) {
      properties.add(DoubleProperty('extent', extent as double));
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
///
/// Note: This currently works as a fixed space since the underlying
/// RenderSliverSpace doesn't support flexible sizing yet.
/// Use [SliverSpace] for fixed spacing.
///
/// Example usage:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SliverAppBar(title: Text('Header')),
///     SliverFlexibleSpace(minExtent: 20, maxExtent: 100), // Currently uses minExtent
///     SliverList(...),
///   ],
/// )
/// ```
class SliverFlexibleSpace extends LeafRenderObjectWidget {
  /// Creates a flexible sliver space.
  ///
  /// Currently uses [minExtent] as the fixed space since flexible
  /// spacing isn't implemented in the render object yet.
  const SliverFlexibleSpace({
    super.key,
    this.minExtent = 0,
    this.maxExtent = double.infinity,
    this.color,
  }) : assert(minExtent >= 0, 'minExtent must be non-negative'),
       assert(maxExtent >= minExtent, 'maxExtent must be >= minExtent');

  /// Minimum extent along the main (scroll) axis.
  final double minExtent;

  /// Maximum extent along the main (scroll) axis.
  /// Note: Currently not used due to render object limitations.
  final double maxExtent;

  /// Optional color for debugging or visual purposes.
  final Color? color;

  @override
  RenderSliverSpace createRenderObject(BuildContext context) {
    return RenderSliverSpace(
      mainAxisExtent: minExtent,
      color: color,
      maxExtent:
          minExtent, // Use minExtent for both since flexibility isn't supported yet
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
