## [0.0.2] - 2025-09-20
### Changed
- `Space`, `SliverSpace`, and `MaxSpace` widgets now support numeric spacing as `num` (both `int` and `double`) instead of only `double`.
- `_effectiveMainAxisExtent` and `numericExtent` now automatically convert `int` to `double`.

---

## [0.0.1] - 2025-09-20
### Added
- Initial release of **Space** package.
- `Space` widget for consistent spacing in layouts.
- `SliverSpace` widget for scrollable areas in `CustomScrollView` and other slivers.
- `MaxSpace` widget for flexible/adaptive spacing.
- Support for both numeric (`num`, i.e., `int` or `double`) spacing and enum-based (`Spacing`) spacing.
- Predefined spacing enum values:
  - `Spacing.tiny`
  - `Spacing.extraSmall`
  - `Spacing.small`
  - `Spacing.medium`
  - `Spacing.large`
  - `Spacing.extraLarge`
  - `Spacing.huge`
  - `Spacing.massive`
- Multiple constructors for quick usage (`Space.small()`, `SliverSpace.large()`, etc.).
- Optional `color` parameter for debugging layout spacing.

---

## [Unreleased]
### Planned
- Responsive spacing values based on screen size.
- Support for orientation-aware spacing.
- Theming integration for global spacing configuration.
