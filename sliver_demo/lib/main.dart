import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RegularAppBarDemo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

      home: const IntermediateSliverDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================
// REGULAR APPBAR DEMO
// ============================================
class RegularAppBarDemo extends StatelessWidget {
  const RegularAppBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regular AppBar'),
        backgroundColor: const Color.fromARGB(255, 15, 83, 139),
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 76, 150, 210),
              child: Text('${index + 1}'),
            ),
            title: Text('Regular AppBar Item ${index + 1}'),
            subtitle: Text(
              'AppBar stays the same size when scrolling',
            ),
          );
        },
      ),
    );
  }
}

// ============================================
// BASIC SLIVER DEMO - Shows three key behaviors
// ============================================
class BasicSliverDemo extends StatelessWidget {
  const BasicSliverDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Basic SliverAppBar demonstrating key behavior properties
          SliverAppBar(
            // Key Behavior 1: expandedHeight - makes the app bar expandable
            expandedHeight: 200.0,

            // Key Behavior 2: pinned - keeps the collapsed app bar visible when scrolling
            pinned: true,

            // Key Behavior 3: floating - makes app bar reappear immediately when scrolling up
            floating: false, // Try changing to true to see the difference
            // Additional: snap - only works when floating is true
            snap: false,

            backgroundColor: Colors.indigo,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Basic SliverAppBar'),
              background: Container(
                color: Colors.indigo.shade300,
                child: const Center(
                  child: Icon(Icons.star, size: 80, color: Colors.white),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Basic SliverAppBar Demo')),
                  );
                },
              ),
            ],
          ),

          // Simple content to scroll through
          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.label_outline),
                  title: Text('Basic Item ${index + 1}'),
                  subtitle: Text('Scroll to see SliverAppBar behavior'),
                ),
              );
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}

// ============================================
// INTERMEDIATE SLIVER DEMO - Better styling
// ============================================
class IntermediateSliverDemo extends StatelessWidget {
  const IntermediateSliverDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Intermediate SliverAppBar with better styling and images
          SliverAppBar(
            expandedHeight: 150.0,
            pinned: false,
            floating: true,
            snap: true, // Works with floating: true
            backgroundColor: const Color(0xFF1E3A8A),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Business Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black45,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1E3A8A), // Blue-900
                          Color(0xFF3B82F6), // Blue-500
                          Color(0xFF60A5FA), // Blue-400
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 60,
                    left: 16,
                    right: 16,
                    child: Center(
                      child: Icon(
                        Icons.dashboard_outlined,
                        size: 50,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              PopupMenuButton<String>(
                onSelected: (value) {},
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'settings',
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem(value: 'help', child: Text('Help')),
                ],
              ),
            ],
          ),

          // Enhanced content with categories
          SliverList(
            delegate: SliverChildListDelegate([
              _buildCategoryHeader('Active Projects'),
            ]),
          ),

          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.2,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_outlined,
                        size: 20,
                        color: const Color(0xFF1E3A8A),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Project ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Active project',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: 8),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E3A8A),
        ),
      ),
    );
  }
}

