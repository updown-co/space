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
/// Space(20)          // 20 pixels
/// Space(Spacing.l)   // Large predefined spacing
/// Space(Spacing.m, crossAxisExtent: 10)  // Medium spacing with cross-axis
/// ```
class Space extends StatelessWidget {
  /// Creates a space with either explicit numeric extent or enum-based spacing.
  ///
  /// The [extent] parameter can be either:
  /// - A [double] for explicit pixel spacing (e.g., `Space(20)`)
  /// - A [Spacing] enum for predefined spacing (e.g., `Space(Spacing.l)`)
  const Space(this.extent, {super.key, this.crossAxisExtent, this.color});

  /// Creates a space with predefined enum-based spacing.
  ///
  /// This is an alternative constructor that's more explicit about using enums.
  const Space.size(Spacing size, {super.key, this.crossAxisExtent, this.color})
    : extent = size;

  /// Creates a tiny space using predefined spacing.
  const Space.tiny({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.tiny;

  /// Creates an extra small space using predefined spacing.
  const Space.extraSmall({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.extraSmall;

  /// Creates a small space using predefined spacing.
  const Space.small({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.small;

  /// Creates a medium space using predefined spacing.
  const Space.medium({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.medium;

  /// Creates a large space using predefined spacing.
  const Space.large({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.large;

  /// Creates an extra large space using predefined spacing.
  const Space.extraLarge({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.extraLarge;

  /// Creates a huge space using predefined spacing.
  const Space.huge({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.huge;

  /// Creates a massive space using predefined spacing.
  const Space.massive({super.key, this.crossAxisExtent, this.color})
    : extent = Spacing.massive;

  /// The extent along the main axis.
  /// Can be either a [double] (pixels) or [Spacing] enum.
  final Object extent;

  /// Spacing along the cross axis. Defaults to 0.
  final double? crossAxisExtent;

  /// Optional color for debugging or visual purposes.
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

  /// Whether this space has any actual extent.
  bool get hasExtent => _effectiveMainAxisExtent > 0;

  /// Returns the spacing type if using enum, null if using numeric value.
  Spacing? get spacingType => extent is Spacing ? extent as Spacing : null;

  /// Returns the numeric value if using explicit pixels, null if using enum.
  double? get numericExtent => extent is double ? extent as double : null;

  @override
  Widget build(BuildContext context) {
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

    if (extent is double) {
      properties.add(DoubleProperty('extent', extent as double));
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
///
/// This is useful when you want the space to adapt to the available room in layouts
/// like Flex, Column, or Row.
class MaxSpace extends StatelessWidget {
  /// Creates a flexible space with a minimum main axis extent.
  ///
  /// The [extent] parameter can be either:
  /// - A [double] for explicit pixel spacing
  /// - A [Spacing] enum for predefined spacing
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
  /// Can be either a [double] (pixels) or [Spacing] enum.
  final Object extent;

  /// Spacing along the cross axis. Defaults to 0.
  final double? crossAxisExtent;

  /// Optional color for debugging or visual purposes.
  final Color? color;

  /// How much space this widget should occupy relative to other flexible widgets.
  final int flex;

  /// Gets the effective main axis extent in pixels.
  double get _effectiveMainAxisExtent {
    if (extent is double) {
      return extent as double;
    } else if (extent is Spacing) {
      return (extent as Spacing).value;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
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

    if (extent is double) {
      properties.add(DoubleProperty('extent', extent as double));
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
