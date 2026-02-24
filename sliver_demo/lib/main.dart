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

      home: const RegularAppBarDemo(),
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
            expandedHeight: 250.0,
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
                        size: 36,
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
            }, childCount: 20),
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

// ============================================
// ADVANCED SLIVER DEMO - Polished with animations
// ============================================
class AdvancedSliverDemo extends StatefulWidget {
  const AdvancedSliverDemo({super.key});

  @override
  State<AdvancedSliverDemo> createState() => _AdvancedSliverDemoState();
}

class _AdvancedSliverDemoState extends State<AdvancedSliverDemo>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fabAnimationController;
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && _showFab) {
        setState(() => _showFab = false);
        _fabAnimationController.reverse();
      } else if (_scrollController.offset <= 200 && !_showFab) {
        setState(() => _showFab = true);
        _fabAnimationController.forward();
      }
    });

    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Advanced SliverAppBar with all the bells and whistles
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            floating: true,
            snap: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Executive Dashboard',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  //  gradient background
                  AnimatedContainer(
                    duration: const Duration(seconds: 3),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0F172A), // Slate-900
                          Color(0xFF1E293B), // Slate-800
                          Color(0xFF334155), // Slate-700
                          Color(0xFF475569), // Slate-600
                        ],
                        stops: [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                  // Animated particles effect (simplified)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Professional indicators
                  const Positioned(
                    top: 80,
                    left: 50,
                    child: Icon(
                      Icons.trending_up,
                      color: Colors.white70,
                      size: 28,
                    ),
                  ),
                  const Positioned(
                    top: 120,
                    right: 60,
                    child: Icon(
                      Icons.analytics_outlined,
                      color: Colors.white54,
                      size: 24,
                    ),
                  ),
                  const Positioned(
                    bottom: 100,
                    left: 80,
                    child: Icon(
                      Icons.assessment_outlined,
                      color: Colors.white60,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: $value'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'profile',
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Profile'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Hero section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Executive Dashboard Overview',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comprehensive analytics and performance metrics with real-time monitoring and detailed insights.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),

          // Featured grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return Card(
                  elevation: 8,
                  shadowColor: const Color(0xFF334155).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF334155).withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.business_center_outlined,
                            size: 30,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Department ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Performance metrics',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: 8),
            ),
          ),

          // List section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Department Reports',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Hero(
                      tag: 'avatar_$index',
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF64748B), Color(0xFF334155)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.folder_open,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    title: Text(
                      'Report ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Monthly analysis \u2022 Updated recently',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF334155),
                      ),
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening Report ${index + 1}'),
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }, childCount: 20),
          ),

          // Bottom spacing
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),

    );
  }
}
