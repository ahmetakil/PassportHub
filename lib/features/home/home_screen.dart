import 'package:flutter/material.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/compare_tab.dart';
import 'package:passport_hub/features/home/tabs/home_tab/explore_tab.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/travel_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const ExploreTab(),
    const TravelTab(),
    const CompareTab(),
  ];

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
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: screens[_selectedIndex],
    );
  }
}
