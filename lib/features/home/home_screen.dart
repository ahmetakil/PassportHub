import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  const HomeScreen({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  int get currentIndex => navigationShell.currentIndex;

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.flight,
        ),
        label: "Travel",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: "Explore",
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
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
      body: Stack(
        children: children.mapIndexed((int index, Widget navigator) {
          return Opacity(
            opacity: index == currentIndex ? 1 : 0,
            child: _branchNavigatorWrapper(index, navigator),
          );
        }).toList(),
      ),
    );
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) {
    return IgnorePointer(
      ignoring: index != currentIndex,
      child: TickerMode(
        enabled: index == currentIndex,
        child: navigator,
      ),
    );
  }
}
