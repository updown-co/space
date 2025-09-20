import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_space/space.dart';

void main() {
  group('SliverSpace Tests', () {
    group('Constructor Tests', () {
      test('creates SliverSpace with numeric extent', () {
        const space = SliverSpace(20.0);
        expect(space.extent, equals(20.0));
        expect(space.color, isNull);
        expect(space.numericExtent, equals(20.0));
        expect(space.spacingType, isNull);
        expect(space.hasExtent, isTrue);
      });

      test('creates SliverSpace with Spacing enum', () {
        const space = SliverSpace(Spacing.large);
        expect(space.extent, equals(Spacing.large));
        expect(space.spacingType, equals(Spacing.large));
        expect(space.numericExtent, isNull);
        expect(space.hasExtent, isTrue);
      });

      test('creates SliverSpace with color', () {
        const space = SliverSpace(10, color: Colors.red);
        expect(space.extent, equals(10));
        expect(space.color, equals(Colors.red));
      });

      test('creates SliverSpace.zero', () {
        const space = SliverSpace.zero();
        expect(space.extent, equals(0));
        expect(space.hasExtent, isFalse);
      });
    });

    group('Named Constructor Tests', () {
      test('SliverSpace.size creates with enum', () {
        const space = SliverSpace.size(Spacing.medium);
        expect(space.extent, equals(Spacing.medium));
        expect(space.spacingType, equals(Spacing.medium));
      });

      test('SliverSpace.tiny creates tiny space', () {
        const space = SliverSpace.tiny();
        expect(space.extent, equals(Spacing.tiny));
        expect(space.spacingType, equals(Spacing.tiny));
      });

      test('SliverSpace.extraSmall creates extra small space', () {
        const space = SliverSpace.extraSmall();
        expect(space.extent, equals(Spacing.extraSmall));
        expect(space.spacingType, equals(Spacing.extraSmall));
      });

      test('SliverSpace.small creates small space', () {
        const space = SliverSpace.small();
        expect(space.extent, equals(Spacing.small));
        expect(space.spacingType, equals(Spacing.small));
      });

      test('SliverSpace.medium creates medium space', () {
        const space = SliverSpace.medium();
        expect(space.extent, equals(Spacing.medium));
        expect(space.spacingType, equals(Spacing.medium));
      });

      test('SliverSpace.large creates large space', () {
        const space = SliverSpace.large();
        expect(space.extent, equals(Spacing.large));
        expect(space.spacingType, equals(Spacing.large));
      });

      test('SliverSpace.extraLarge creates extra large space', () {
        const space = SliverSpace.extraLarge();
        expect(space.extent, equals(Spacing.extraLarge));
        expect(space.spacingType, equals(Spacing.extraLarge));
      });

      test('SliverSpace.huge creates huge space', () {
        const space = SliverSpace.huge();
        expect(space.extent, equals(Spacing.huge));
        expect(space.spacingType, equals(Spacing.huge));
      });

      test('SliverSpace.massive creates massive space', () {
        const space = SliverSpace.massive();
        expect(space.extent, equals(Spacing.massive));
        expect(space.spacingType, equals(Spacing.massive));
      });
    });

    group('Property Tests', () {
      test('hasExtent returns false for zero extent', () {
        const space = SliverSpace.zero();
        expect(space.hasExtent, isFalse);
      });

      test('hasExtent returns true for positive extent', () {
        const space = SliverSpace(10.0);
        expect(space.hasExtent, isTrue);
      });
    });

    group('Widget Tests', () {
      testWidgets('SliverSpace renders in CustomScrollView', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  const SliverAppBar(title: Text('Test')),
                  const SliverSpace(50.0),
                  SliverList(
                    delegate: SliverChildListDelegate([const Text('Content')]),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Test'), findsOneWidget);
        expect(find.text('Content'), findsOneWidget);
      });

      testWidgets('SliverSpace with enum spacing renders', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  const SliverSpace(Spacing.large),
                  SliverList(
                    delegate: SliverChildListDelegate([const Text('Content')]),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Content'), findsOneWidget);
      });

      testWidgets('SliverSpace.large renders', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  const SliverSpace.large(),
                  SliverList(
                    delegate: SliverChildListDelegate([const Text('Content')]),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Content'), findsOneWidget);
      });
    });
  });

  group('SliverFlexibleSpace Tests', () {
    group('Constructor Tests', () {
      test('creates SliverFlexibleSpace with default values', () {
        const space = SliverFlexibleSpace();
        expect(space.minExtent, equals(0));
        expect(space.maxExtent, equals(double.infinity));
        expect(space.color, isNull);
      });

      test('creates SliverFlexibleSpace with custom values', () {
        const space = SliverFlexibleSpace(
          minExtent: 20,
          maxExtent: 100,
          color: Colors.blue,
        );
        expect(space.minExtent, equals(20));
        expect(space.maxExtent, equals(100));
        expect(space.color, equals(Colors.blue));
      });
    });
  });

  group('Space Tests', () {
    group('Constructor Tests', () {
      test('creates Space with numeric extent', () {
        const space = Space(20.0);
        expect(space.extent, equals(20.0));
        expect(space.crossAxisExtent, isNull);
        expect(space.color, isNull);
        expect(space.numericExtent, equals(20.0));
        expect(space.spacingType, isNull);
        expect(space.hasExtent, isTrue);
      });

      test('creates Space with Spacing enum', () {
        const space = Space(Spacing.medium);
        expect(space.extent, equals(Spacing.medium));
        expect(space.spacingType, equals(Spacing.medium));
        expect(space.numericExtent, isNull);
        expect(space.hasExtent, isTrue);
      });

      test('creates Space with crossAxisExtent and color', () {
        const space = Space(15, crossAxisExtent: 10, color: Colors.green);
        expect(space.extent, equals(15));
        expect(space.crossAxisExtent, equals(10));
        expect(space.color, equals(Colors.green));
      });
    });

    group('Named Constructor Tests', () {
      test('Space.size creates with enum', () {
        const space = Space.size(Spacing.small);
        expect(space.extent, equals(Spacing.small));
        expect(space.spacingType, equals(Spacing.small));
      });

      test('Space.tiny creates tiny space', () {
        const space = Space.tiny();
        expect(space.extent, equals(Spacing.tiny));
        expect(space.spacingType, equals(Spacing.tiny));
      });

      test('Space.extraSmall creates extra small space', () {
        const space = Space.extraSmall();
        expect(space.extent, equals(Spacing.extraSmall));
        expect(space.spacingType, equals(Spacing.extraSmall));
      });

      test('Space.small creates small space', () {
        const space = Space.small();
        expect(space.extent, equals(Spacing.small));
        expect(space.spacingType, equals(Spacing.small));
      });

      test('Space.medium creates medium space', () {
        const space = Space.medium();
        expect(space.extent, equals(Spacing.medium));
        expect(space.spacingType, equals(Spacing.medium));
      });

      test('Space.large creates large space', () {
        const space = Space.large();
        expect(space.extent, equals(Spacing.large));
        expect(space.spacingType, equals(Spacing.large));
      });

      test('Space.extraLarge creates extra large space', () {
        const space = Space.extraLarge();
        expect(space.extent, equals(Spacing.extraLarge));
        expect(space.spacingType, equals(Spacing.extraLarge));
      });

      test('Space.huge creates huge space', () {
        const space = Space.huge();
        expect(space.extent, equals(Spacing.huge));
        expect(space.spacingType, equals(Spacing.huge));
      });

      test('Space.massive creates massive space', () {
        const space = Space.massive();
        expect(space.extent, equals(Spacing.massive));
        expect(space.spacingType, equals(Spacing.massive));
      });
    });

    group('Property Tests', () {
      test('hasExtent returns false for zero extent', () {
        const space = Space(0.0);
        expect(space.hasExtent, isFalse);
      });

      test('hasExtent returns true for positive extent', () {
        const space = Space(15.0);
        expect(space.hasExtent, isTrue);
      });
    });

    group('Widget Tests', () {
      testWidgets('Space renders in Column', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [Text('Before'), Space(20.0), Text('After')],
              ),
            ),
          ),
        );

        expect(find.text('Before'), findsOneWidget);
        expect(find.text('After'), findsOneWidget);
      });

      testWidgets('Space with enum spacing renders in Row', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Row(
                children: [Text('Left'), Space(Spacing.large), Text('Right')],
              ),
            ),
          ),
        );

        expect(find.text('Left'), findsOneWidget);
        expect(find.text('Right'), findsOneWidget);
      });

      testWidgets('Space.medium renders', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [Text('Top'), Space.medium(), Text('Bottom')],
              ),
            ),
          ),
        );

        expect(find.text('Top'), findsOneWidget);
        expect(find.text('Bottom'), findsOneWidget);
      });

      testWidgets('Space with crossAxisExtent and color', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  Text('Top'),
                  Space(20.0, crossAxisExtent: 100, color: Colors.red),
                  Text('Bottom'),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Top'), findsOneWidget);
        expect(find.text('Bottom'), findsOneWidget);
      });
    });
  });

  group('MaxSpace Tests', () {
    group('Constructor Tests', () {
      test('creates MaxSpace with extent', () {
        const space = MaxSpace(10);
        expect(space.extent, equals(10));
        expect(space.flex, equals(1));
        expect(space.crossAxisExtent, isNull);
        expect(space.color, isNull);
      });

      test('creates MaxSpace.fill', () {
        const space = MaxSpace.fill();
        expect(space.extent, equals(0));
        expect(space.flex, equals(1));
      });

      test('creates MaxSpace with all parameters', () {
        const space = MaxSpace(
          Spacing.large,
          crossAxisExtent: 50,
          color: Colors.yellow,
          flex: 2,
        );
        expect(space.extent, equals(Spacing.large));
        expect(space.crossAxisExtent, equals(50));
        expect(space.color, equals(Colors.yellow));
        expect(space.flex, equals(2));
      });
    });
    group('Widget Tests', () {
      testWidgets('MaxSpace renders in Column', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [Text('Top'), MaxSpace(20.0), Text('Bottom')],
              ),
            ),
          ),
        );

        expect(find.text('Top'), findsOneWidget);
        expect(find.text('Bottom'), findsOneWidget);
      });

      testWidgets('MaxSpace.fill renders', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [Text('Top'), MaxSpace.fill(), Text('Bottom')],
              ),
            ),
          ),
        );

        expect(find.text('Top'), findsOneWidget);
        expect(find.text('Bottom'), findsOneWidget);
      });
    });
  });

  group('Integration Tests', () {
    testWidgets('Multiple space types in scrollable', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(title: Text('Header')),
                const SliverSpace.large(),
                const SliverSpace(30.0),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const Column(
                      children: [
                        Text('Item 1'),
                        Space.medium(),
                        Text('Item 2'),
                        Space(15.0),
                        Text('Item 3'),
                      ],
                    ),
                  ]),
                ),
                const SliverSpace.huge(),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('Spaces in different layout widgets', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Row(children: [Text('Left'), Space.large(), Text('Right')]),
                Space.medium(),
                Row(children: [Text('A'), MaxSpace.fill(), Text('B')]),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Left'), findsOneWidget);
      expect(find.text('Right'), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
    });
  });
}
