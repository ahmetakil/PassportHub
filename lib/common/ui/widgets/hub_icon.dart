import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension HubIconsExtension on HubIcons {
  String get path {
    switch (this) {
      case HubIcons.medal:
        return "assets/icons/medal.svg";
    }
  }
}

enum HubIcons {
  medal,
}

class HubIcon extends StatelessWidget {
  final HubIcons icon;
  final double? width;
  final double? height;

  const HubIcon(
    this.icon, {
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.path,
      width: width,
      height: height,
    );
  }
}
