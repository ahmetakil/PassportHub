import 'package:flutter/material.dart';
import 'package:passport_hub/features/home/tabs/home_tab/home_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const HomeTab(),
    const HomeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.web),
        label: "Home",
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.web), label: "Compare"),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      appBar: AppBar(
        title: const Text("Passport Hub"),
        centerTitle: true,
      ),
      body: screens[_selectedIndex],
    );
  }
}
