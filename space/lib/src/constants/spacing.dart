// ------------------------------------------------------------ //
//  spacing.dart
//
//  Created by Siva Sankar on 2025-09-19.
// ------------------------------------------------------------ //

/// A set of predefined spacing values used throughout the UI for
/// consistent padding, margin, and layout gaps.
///
/// ### Why use `Spacing`?
/// - Provides **consistent spacing** across the app.
/// - Easier to maintain design system values in one place.
/// - Improves readability compared to "magic numbers" (e.g., `SizedBox(height: 16)`).
/// - Works well with responsive or theme-driven UIs.
///
/// ### Usage example:
/// ```dart
/// Space(Spacing.medium); // Adds 16.0 px vertical/horizontal space
/// Column(
///   children:[
///   Text("Hello World"),
///   Space(Spacing.large), // Adds 24.0 px vertical space
///   Text("Sadhanam kayyil undo..???"),
///   ]
/// )
/// ```
///
/// ### Naming convention:
/// - `tiny` → 2.0
/// - `extraSmall` → 4.0
/// - `small` → 8.0
/// - `medium` → 16.0
/// - `large` → 24.0
/// - `extraLarge` → 32.0
/// - `huge` → 40.0
/// - `massive` → 48.0
enum Spacing {
  /// Tiny spacing (`2.0`).
  tiny,

  /// Extra small spacing (`4.0`).
  extraSmall,

  /// Small spacing (`8.0`).
  small,

  /// Medium spacing (`16.0`).
  medium,

  /// Large spacing (`24.0`).
  large,

  /// Extra large spacing (`32.0`).
  extraLarge,

  /// Huge spacing (`40.0`).
  huge,

  /// Massive spacing (`48.0`).
  massive,
}

/// Extension to convert [Spacing] enum values into concrete `double` values.
///
/// Provides the actual spacing measurement in logical pixels (dp)
/// for use in Flutter widgets such as `SizedBox`, `Padding`, and `Margin`.
extension SpacingValue on Spacing {
  /// Returns the `double` value (in logical pixels) corresponding to the [Spacing] size.
  double get value {
    switch (this) {
      case Spacing.tiny:
        return 2.0;
      case Spacing.extraSmall:
        return 4.0;
      case Spacing.small:
        return 8.0;
      case Spacing.medium:
        return 16.0;
      case Spacing.large:
        return 24.0;
      case Spacing.extraLarge:
        return 32.0;
      case Spacing.huge:
        return 40.0;
      case Spacing.massive:
        return 48.0;
    }
  }
}
