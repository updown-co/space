import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_space/src/constants/spacing.dart';
import 'package:flutter_space/src/rendering/space.dart';

/// A widget that creates space along the main axis of its parent layout.
///
/// Supports both explicit numeric spacing and enum-based predefined spacing.
/// Automatically adapts to the scroll direction of ancestor scrollables.
///
/// Examples:
/// ```dart
/// Space(20)          // 20 pixels (int or double)
/// Space(Spacing.l)   // Large predefined spacing
/// Space(Spacing.m, crossAxisExtent: 10)  // Medium spacing with cross-axis
/// ```
class Space extends StatelessWidget {
  /// Creates a space with either explicit numeric extent or enum-based spacing.
  ///
  /// The [extent] parameter can be either:
  /// - a [num] (int or double) for explicit pixel spacing (e.g., `Space(20)` or `Space(20.0)`)
  /// - a [Spacing] enum for predefined spacing (e.g., `Space(Spacing.l)`)
  const Space(this.extent, {super.key, this.crossAxisExtent, this.color});

  /// Creates a space with predefined enum-based spacing.
  const Space.size(Spacing size, {super.key, this.crossAxisExtent, this.color})
    : extent = size;

  const Space.tiny({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.tiny;

  const Space.extraSmall({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.extraSmall;

  const Space.small({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.small;

  const Space.medium({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.medium;

  const Space.large({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.large;

  const Space.extraLarge({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.extraLarge;

  const Space.huge({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.huge;

  const Space.massive({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.massive;

  /// The extent along the main axis.
  /// Can be either a [num] (int/double) or [Spacing] enum.
  final Object extent;

  /// Spacing along the cross axis. Defaults to 0.
  final double? crossAxisExtent;

  /// Optional color for debugging or visual purposes.
  final Color? color;

  /// Gets the effective main axis extent in pixels.
  double get _effectiveMainAxisExtent {
    if (extent is num) {
      return (extent as num).toDouble();
    } else if (extent is Spacing) {
      return (extent as Spacing).value;
    }
    return 0.0;
  }

  /// Whether this space has any actual extent.
  bool get hasExtent => _effectiveMainAxisExtent > 0;

  /// Returns the spacing type if using enum, null if using numeric value.
  Spacing? get spacingType => extent is Spacing ? extent as Spacing : null;

  /// Returns the numeric value if using explicit pixels, null if using enum.
  double? get numericExtent =>
      extent is num ? (extent as num).toDouble() : null;

  @override
  Widget build(BuildContext context) {
    // Validate the extent parameter: allow num (int/double) or Spacing.
    assert(
      extent is num || extent is Spacing,
      'extent must be either a num (int/double) or Spacing enum. Got: ${extent.runtimeType}',
    );

    if (extent is num) {
      final val = (extent as num).toDouble();
      assert(val >= 0, 'numeric extent must be non-negative. Got: $extent');
    }

    final scrollable = Scrollable.maybeOf(context);
    final fallbackDirection = scrollable?.axisDirection != null
        ? axisDirectionToAxis(scrollable!.axisDirection)
        : null;

    return _RawSpace(
      _effectiveMainAxisExtent,
      crossAxisExtent: crossAxisExtent ?? 0,
      color: color,
      fallbackDirection: fallbackDirection,
    );
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
    properties.add(DoubleProperty('crossAxisExtent', crossAxisExtent));
    properties.add(ColorProperty('color', color));
    properties.add(
      FlagProperty('hasExtent', value: hasExtent, ifFalse: 'zero extent'),
    );
  }
}

/// A flexible space widget that expands to fill available space along the main axis.
class MaxSpace extends StatelessWidget {
  /// Creates a flexible space with a minimum main axis extent.
  ///
  /// The [extent] parameter can be either:
  /// - a [num] for explicit pixel spacing
  /// - a [Spacing] enum for predefined spacing
  const MaxSpace(
    this.extent, {
    super.key,
    this.crossAxisExtent,
    this.color,
    this.flex = 1,
  });

  /// Creates a flexible space that takes all available space.
  const MaxSpace.fill({
    super.key,
    this.crossAxisExtent,
    this.color,
    this.flex = 1,
  }) : extent = 0.0;

  /// Minimum extent along the main axis.
  /// Can be either a [num] (int/double) or [Spacing] enum.
  final Object extent;

  /// Spacing along the cross axis. Defaults to 0.
  final double? crossAxisExtent;

  /// Optional color for debugging or visual purposes.
  final Color? color;

  /// How much space this widget should occupy relative to other flexible widgets.
  final int flex;

  /// Gets the effective main axis extent in pixels.
  double get _effectiveMainAxisExtent {
    if (extent is num) {
      return (extent as num).toDouble();
    } else if (extent is Spacing) {
      return (extent as Spacing).value;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    // Validate the extent parameter
    assert(
      extent is num || extent is Spacing,
      'extent must be either a num (int/double) or Spacing enum. Got: ${extent.runtimeType}',
    );

    if (extent is num) {
      final val = (extent as num).toDouble();
      assert(val >= 0, 'numeric extent must be non-negative. Got: $extent');
    }

    return Flexible(
      flex: flex,
      child: _RawSpace(
        _effectiveMainAxisExtent,
        crossAxisExtent: crossAxisExtent ?? 0,
        color: color,
      ),
    );
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
    properties.add(DoubleProperty('crossAxisExtent', crossAxisExtent));
    properties.add(ColorProperty('color', color));
    properties.add(IntProperty('flex', flex));
  }
}

/// Internal render object widget that handles the actual space rendering.
class _RawSpace extends LeafRenderObjectWidget {
  const _RawSpace(
    this.mainAxisExtent, {
    required this.crossAxisExtent,
    this.color,
    this.fallbackDirection,
  });

  final double mainAxisExtent;
  final double crossAxisExtent;
  final Color? color;
  final Axis? fallbackDirection;

  @override
  RenderSpace createRenderObject(BuildContext context) {
    return RenderSpace(
      mainAxisExtent: mainAxisExtent,
      crossAxisExtent: crossAxisExtent,
      color: color,
      fallbackDirection: fallbackDirection,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSpace renderObject) {
    renderObject
      ..mainAxisExtent = mainAxisExtent
      ..crossAxisExtent = crossAxisExtent
      ..color = color
      ..fallbackDirection = fallbackDirection;
  }
}
