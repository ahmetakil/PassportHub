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

extension HubImagesExtension on HubImages {
  String get path {
    switch (this) {
      case HubImages.cartoonAirplane:
        return "assets/images/cartoon_airplane.png";
      case HubImages.comparePreview:
        return "assets/images/compare_preview.png";
    }
  }
}

enum HubIcons {
  medal,
}

enum HubImages {
  cartoonAirplane,
  comparePreview,
}

class HubImage extends StatelessWidget {
  final HubImages image;
  final double? width;
  final double? height;
  final BoxFit fit;

  const HubImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image.path,
      width: width,
      height: height,
      fit: fit,
    );
  }
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
