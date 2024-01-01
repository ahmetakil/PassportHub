import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';

class HomeScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final Widget child;

  const HomeScreen({
    super.key,
    required this.navigationShell,
    required this.child,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: "Explore",
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.flight,
        ),
        label: "Travel",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.compare_arrows),
        label: "Compare",
      ),
    ];

    return HubScaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        backgroundColor: Colors.white,
        items: bottomNavigationBarItems,
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (int index) {
          widget.navigationShell.goBranch(
            index,
          );
        },
      ),
      body: widget.child,
    );
  }
}
