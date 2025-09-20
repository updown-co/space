// example/lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_space/flutter_space.dart';

void main() {
  runApp(const SpaceExampleApp());
}

class SpaceExampleApp extends StatelessWidget {
  const SpaceExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Example',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Space Example'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Basic"),
              Tab(text: "Slivers"),
            ],
          ),
        ),
        body: const TabBarView(children: [BasicExample(), SliverExample()]),
      ),
    );
  }
}

/// Example: using Space in regular layouts
class BasicExample extends StatelessWidget {
  const BasicExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Above Tiny Space"),
          // Full width colored space
          Space.tiny(
            color: Colors.red.withOpacity(0.3),
            crossAxisExtent: double.infinity,
          ),
          const Text("Below Tiny, Above Large"),
          // Centered colored space with fixed width
          Space.large(
            color: Colors.blue.withOpacity(0.3),
            crossAxisExtent: double.infinity,
          ),
          const Text("Below Large, Above Custom 40"),
          // Need to add crossAxisExtent to make the color
          const Space(40, color: Colors.greenAccent),
          const Text("End"),
        ],
      ),
    );
  }
}

/// Example: using SliverSpace inside CustomScrollView
class SliverExample extends StatelessWidget {
  const SliverExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          expandedHeight: 120,
          flexibleSpace: FlexibleSpaceBar(title: Text('Sliver Example')),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text("Scroll down to see SliverSpaces"),
          ),
        ),
        SliverSpace.medium(color: Colors.red),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(title: Text("Item $index")),
            childCount: 10,
          ),
        ),
        SliverSpace.large(color: Colors.purple.withOpacity(0.3)),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text("End of List"),
          ),
        ),
      ],
    );
  }
}
