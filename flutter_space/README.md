# Space

A Flutter package to create flexible, intuitive, and customizable spacing in your layouts, inspired by [`package:gap`](https://pub.dev/packages/gap) but improved and more powerful.  

With `Space`, you can add consistent spacing between widgets, create sliver gaps in scrollable areas, and even build flexible layouts with adaptive space. Works perfectly with Flutter's `Column`, `Row`, `Flex`, `CustomScrollView`, and other sliver-based scrollable widgets.

---

## Features

- Easy-to-use spacing widgets for both regular layouts and slivers.
- Supports numeric spacing (`double`) or predefined spacing enums (`Spacing.tiny`, `Spacing.large`, etc.).
- Sliver-compatible: use `SliverSpace` for scrollable areas.
- Flexible and adaptive space with `MaxSpace`.
- Optional `color` parameter for debugging or visual separation.
- Improved API inspired by `package:gap`, with more customization options.
- Multiple constructors for quick predefined spacing:
  - `Space.small()`
  - `Space.medium()`
  - `Space.large()`
  - `Space.extraLarge()`, etc.

---

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_space: ^0.0.1
```

Then run:

```bash
flutter pub get
```

or

```bash
flutter pub add flutter_space
```


---

## Usage

### Regular space

```dart
Column(
  children: [
    Text('Hello'),
    Space(20), // 20 pixels of space
    Text('World'),
    Space(Spacing.large), // Predefined large spacing
  ],
)
```

### Using predefined sizes

```dart
Column(
  children: [
    Text('Tiny space above'),
    Space.tiny(),
    Text('Extra large space below'),
    Space.extraLarge(),
  ],
)
```

### Flexible space in layouts

```dart
Row(
  children: [
    Text('Start'),
    MaxSpace.fill(), // takes all remaining space
    Text('End'),
  ],
)
```

### Sliver spacing

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(title: Text('Header')),
    SliverSpace(20), // 20 pixels of sliver space
    SliverSpace.large(), // Predefined large sliver space
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('Item $index')),
        childCount: 10,
      ),
    ),
  ],
)
```

---

## Predefined Spacing Enum

```dart
enum Spacing {
  tiny,        // small value
  extraSmall,  
  small,
  medium,
  large,
  extraLarge,
  huge,
  massive,
}
```

Use like this:

```dart
Space(Spacing.large)
SliverSpace(Spacing.medium)
```

---

## Debugging

Optionally, you can add a `color` to make spaces visible for layout debugging:

```dart
Space.large(color: Colors.red.withOpacity(0.3))
SliverSpace.medium(color: Colors.blue.withOpacity(0.3))
```

---

## Why Space?

* **Flexible:** Works with both fixed and adaptive layouts.
* **Sliver-ready:** Perfect for scrollable UI designs.
* **Developer-friendly:** Easy constructors for common spacing.
* **Improved over `gap`:** Adds flexibility, sliver support, and visual debugging.

---

## Credits

Developed by **Siva Sankar**
Company: **UpDown Co**

Inspired by [`package:gap`](https://pub.dev/packages/gap).

