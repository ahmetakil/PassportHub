import 'package:flutter/material.dart';

class HubScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Drawer? drawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final BorderRadius borderRadius;
  final bool removePadding;
  final BottomNavigationBar? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;

  const HubScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    required this.borderRadius,
    required this.removePadding,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: appBar,
    );
  }
}
